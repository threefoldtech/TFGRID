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
	farms []TFGridFarmer
}

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

pub fn (mut explorer Explorer) entity_by_id (id u32) ? TFGridEntity {
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

pub fn (mut explorer Explorer) twin_by_id (id u32) ? TFGridTwin {
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
		query: '{ nodes { gridVersion, nodeId, farmId, sru, cru, hru, mru, location{ latitude, longitude }, pubKey, address, countryId, cityId } }',
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

pub fn (mut explorer Explorer) node_by_id (id u32) ? TFGridNode {
	mut query := GraphqlQuery{
		query: '{ nodes(where: { nodeId_eq: $id }) { gridVersion, nodeId, farmId, sru, cru, hru, mru, location{ latitude, longitude }, pubKey, address, countryId, cityId } }',
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

pub fn (mut explorer Explorer) nodes_by_resources (sru u32, cru u32, hru u32, mru u32) ? []TFGridNode {
	mut query := GraphqlQuery{
		query: '{ nodes(where: { sru_gt: $sru, cru_gt: $cru, hru_gt: $hru, mru_gt: $mru }) { gridVersion, nodeId, farmId, sru, cru, hru, mru, location{ latitude, longitude }, pubKey, address, countryId, cityId } }',
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

pub fn (mut explorer Explorer) farms_list() ? []TFGridFarmer {
	mut query := GraphqlQuery{
		query: '{ farms { name, farmId, twinId, gridVersion, countryId, cityId, pricingPolicyId } }',
		operation: 'getAll'
	}

	req := make_post_request_query(explorer.ipaddr, query)?
	
	res := req.do() ?

	data := json.decode(ReqData, res.text) or {
		eprintln('failed to decode json')
		return []TFGridFarmer{}
	}
	return data.data.farms
}

pub fn (mut explorer Explorer) farm_by_id (id u32) ? TFGridFarmer {
	mut query := GraphqlQuery{
		query: '{ farms(where: { farmId_eq: $id }) { name, farmId, twinId, gridVersion, countryId, cityId, pricingPolicyId } }',
		operation: 'getOne',
	}

	req := make_post_request_query(explorer.ipaddr, query)?

	res := req.do() ?

	data := json.decode(ReqData, res.text) or {
		eprintln('failed to decode json')
		return TFGridFarmer{}
	}

	if data.data.farms.len > 0 {
		return data.data.farms[0]
	} else {
		eprintln('no node found')
		return TFGridFarmer{}
	}
}

pub fn make_post_request_query(url string, query GraphqlQuery) ?http.Request {
	post := http.method_from_str('POST')
	data := json.encode(query)
	mut req := http.new_request(post, url, data) ?
	req.add_header('Content-Type', 'application/json')

	return req
}