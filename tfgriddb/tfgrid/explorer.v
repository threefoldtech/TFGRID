module tfgrid

import net.http
import json
import strconv

// logic needs to be here to fetch basic info from TFGrid DB

pub struct Explorer {
	ipaddr string
}

pub fn explorer_new() ?Explorer {
	mut explorer := Explorer{
		ipaddr: 'https://explorer.devnet.grid.tf/graphql/'
	}

	// now add the ipaddresses in code which explorers can be reached

	return explorer
}

pub struct VarValue {
	typ VarType
	value string
}

pub enum VarType {
	string = 0
	number = 1
	bool = 2	
}

struct GraphqlQuery {
mut:
	query string
	operation string
	variables string
}

struct Variable {
	id string
}

struct ReqData {
	data Body
}

struct Body {
	entities []TFGridEntity
}

// TODO: will need methods here to use the https client
pub fn (mut explorer Explorer) entity_list() ? []TFGridEntity {
	mut query := GraphqlQuery{
		query: '{ entities { name, entityId, name, gridVersion, countryId, cityId } }',
		operation: 'getAll'
	}

	req := make_post_request_query(explorer.ipaddr, query)?
	
	res := req.do() ?

	data := json.decode(ReqData, res.text) or {
		eprintln('failed to decode json')
		return []TFGridEntity{}
	}
	return data.data.entities
}

pub fn (mut explorer Explorer) entity_by_id (id string) ? TFGridEntity {
	var := parse_var("id", VarValue{typ: VarType.string, value: id})
	println(var)

	mut query := GraphqlQuery{
		query: '{ entities(where: {entityId_eq: \$id }) { name } }',
		operation: 'getOne',
	}

	query.variables = var

	req := make_post_request_query(explorer.ipaddr, query)?

	println(req)

	res := req.do() ?
	println(res)
	data := json.decode(ReqData, res.text) or {
		eprintln('failed to decode json')
		return TFGridEntity{}
	}

	if data.data.entities.len > 0 {
		return data.data.entities[0]
	} else {
		eprintln('no entity found')
		return TFGridEntity{}
	}
}

pub fn make_post_request_query(url string, query GraphqlQuery) ?http.Request {
	post := http.method_from_str('POST')
	data := json.encode(query)
	mut req := http.new_request(post, url, data) ?
	req.add_header('Content-Type', 'application/json')

	return req
}

fn parse_var(key string, _type VarValue) string {
	if _type.typ == VarType.string {
		stru := &StringVar {
			key: key,
			value: _type.value
		}

		return json.encode(stru)
	} else if _type.typ == VarType.number {
		stru := &IntVar {
			key: key,
			value: strconv.atoi(_type.value)
		}

		return json.encode(stru)
	} else if _type.typ == VarType.bool {
		stru := &BooleanVar {
			key: key,
			value: _type.value == "true"
		}

		return json.encode(stru)
	}

	return ""
}

struct IntVar {
	key string
	value int
}

struct BooleanVar {
	key string
	value bool
}

struct StringVar {
	key string
	value string
}