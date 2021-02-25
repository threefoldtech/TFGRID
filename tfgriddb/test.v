module main

import tfgrid

fn main () {
	mut tfgrid := tfgrid.tfgrid_new() ?

	entities := tfgrid.entity_list()?
	println(entities)

	entity := tfgrid.entity_get_by_id("1") ?
	print(entity)

	twins := tfgrid.twin_list()?
	println(twins)

	twin := tfgrid.twin_get_by_id("1") ?
	print(twin)

	nodes := tfgrid.nodes_list()?
	println(nodes)

	node := tfgrid.nodes_get_by_id("1") ?
	print(node)

	farms := tfgrid.farms_list()?
	println(farms)																												

	farm := tfgrid.farm_get_by_id("1") ?
	print(farm)
}
