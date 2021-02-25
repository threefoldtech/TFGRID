module tfgrid

//commands which are execute by our digital twin and it serves as proxy to the TFGrid DB
// we do this because we don't have client for parity

struct TFGrid{
	//gives us connection to our personal twin, which we need as proxy to the TFGrid DB
	mytwin &MyTwin

}

//inits grid obj with connection to your own digital twin
fn new(mut twin &MyTwin)? TFGrid {
	twin.init()?
	mut grid := TFGrid{mytwin:twin} 
	return grid
}

//GET TO THE OBJECTS OF THE GRID DB (get only for now)

fn (mut grid TFGrid) entity_get(entity int) TFGridEntity{
	//all commands here will be done to the personal twin as proxy which will get the info from the TFGrid DB and relay for us
	//we receive as json and which can deserialize here

	return TFGridEntity{}

}

fn (mut grid TFGrid) farmer_get(entity int) TFGridFarmer{
	//all commands here will be done to the personal twin as proxy which will get the info from the TFGrid DB and relay for us
	//we receive as json and which can deserialize here

	return TFGridFarmer{}

}

fn (mut grid TFGrid) twin_get(entity int) TFGridTwin{
	//all commands here will be done to the personal twin as proxy which will get the info from the TFGrid DB and relay for us
	//we receive as json and which can deserialize here

	return TFGridTwin{}

}

fn (mut grid TFGrid) node_get(entity int) TFGridNode{
	//all commands here will be done to the personal twin as proxy which will get the info from the TFGrid DB and relay for us
	//we receive as json and which can deserialize here

	return TFGridNode{}

}



//what did we forget
