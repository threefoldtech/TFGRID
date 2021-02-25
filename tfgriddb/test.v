module main

import tfgrid

fn main () {
	mut tfgrid := tfgrid.tfgrid_new() ?

	// entities := tfgrid.entity_list()?
	// println(entities)

	entity := tfgrid.entity_get_by_id("1") ?
	print(entity)
}
