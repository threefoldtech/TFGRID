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
	twins []TFGridTwin
	nodes []TFGridNode
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

// TODO: will need methods here to use the https client
pub fn (mut explorer Explorer) twin_list() ? []TFGridTwin {
	mut query := GraphqlQuery{
		query: '{ twins { twinId, ip, gridVersion, address } }',
		operation: 'getAll'
	}

	req := make_post_request_query(explorer.ipaddr, query)?
	
	res := req.do() ?

	data := json.decode(ReqData, res.text) or {
		eprintln('failed to decode json')
		return []TFGridTwin{}
	}
	return data.data.twins
}

pub fn (mut explorer Explorer) twin_by_id (id string) ? TFGridTwin {
	mut query := GraphqlQuery{
		query: '{ twins(where: {twinId_eq: $id }) { twinId, ip, gridVersion, address } }',
		operation: 'getOne',
	}

	req := make_post_request_query(explorer.ipaddr, query)?

	res := req.do() ?

	data := json.decode(ReqData, res.text) or {
		eprintln('failed to decode json')
		return TFGridTwin{}
	}

	if data.data.twins.len > 0 {
		return data.data.twins[0]
	} else {
		eprintln('no twin found')
		return TFGridTwin{}
	}
}

pub fn (mut explorer Explorer) nodes_list() ? []TFGridNode {
	mut query := GraphqlQuery{
		query: '{ nodes { gridVersion, nodeId, farmId, resources{ sru, cru, hru, mru } location{ latitude, longitude }, pubKey, address, countryId, cityId } }',
		operation: 'getAll'
	}

	req := make_post_request_query(explorer.ipaddr, query)?
	
	res := req.do() ?

	data := json.decode(ReqData, res.text) or {
		eprintln('failed to decode json')
		return []TFGridNode{}
	}
	return data.data.nodes
}

pub fn (mut explorer Explorer) node_by_id (id string) ? TFGridNode {
	mut query := GraphqlQuery{
		query: '{ nodes(where: { nodeId_eq: $id }) { gridVersion, nodeId, farmId, resources{ sru, cru, hru, mru } location{ latitude, longitude }, pubKey, address, countryId, cityId } }',
		operation: 'getOne',
	}

	req := make_post_request_query(explorer.ipaddr, query)?

	res := req.do() ?

	data := json.decode(ReqData, res.text) or {
		eprintln('failed to decode json')
		return TFGridNode{}
	}

	if data.data.nodes.len > 0 {
		return data.data.nodes[0]
	} else {
		eprintln('no node found')
		return TFGridNode{}
	}
}

pub fn make_post_request_query(url string, query GraphqlQuery) ?http.Request {
	post := http.method_from_str('POST')
	data := json.encode(query)
	mut req := http.new_request(post, url, data) ?
	req.add_header('Content-Type', 'application/json')

	return req
}