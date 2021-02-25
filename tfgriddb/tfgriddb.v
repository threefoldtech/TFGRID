module tfgrid

// commands which are execute by our digital twin and it serves as proxy to the TFGrid DB
// we do this because we don't have client for parity

struct TFGrid {
	// gives us connection to our personal twin, which we need as proxy to the TFGrid DB for the write actions
	mytwin   &MyTwin
	explorer Explorer
}

// inits grid obj with connection to your own digital twin
// will use personal twin as well as explorer to get info
fn tfgrid_new(mut twin MyTwin) ?TFGrid {
	twin.init() ?
	mut explorer := explorer_new() ?
	mut grid := TFGrid{
		mytwin: twin
		explorer: explorer
	}
	return grid
}

// GET TO THE OBJECTS OF THE GRID DB (get only for now)

fn (mut grid TFGrid) entity_get(entity int) TFGridEntity {
	// use explorer graphql interface
	return TFGridEntity{}
}

fn (mut grid TFGrid) farmer_get(entity int) TFGridFarmer {
	// use explorer graphql interface
	return TFGridFarmer{}
}

fn (mut grid TFGrid) twin_get(entity int) TFGridTwin {
	// use explorer graphql interface
	return TFGridTwin{}
}

fn (mut grid TFGrid) node_get(entity int) TFGridNode {
	// use explorer graphql interface
	return TFGridNode{}
}

// TODO: arguments to be added
fn (mut grid TFGrid) node_register() TFGridNode {
	// use personal digital twin as proxy
	return TFGridNode{}
}

// what did we forget
