module tfgrid

import net.http
import json

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

struct GraphqlQuery {
mut:
	query string
	operation string
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
	mut query := GraphqlQuery{
		query: '{ entities(where: {entityId_eq: $id }) { name, entityId, name, gridVersion, countryId, cityId } }',
		operation: 'getOne',
	}

	req := make_post_request_query(explorer.ipaddr, query)?

	res := req.do() ?

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