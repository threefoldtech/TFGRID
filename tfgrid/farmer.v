module tfgrid


struct Farmer{
	// digital twin responsible for this farmer
	twin Twin
	//optional to be decided how to be used by user
	description string
	tfgrid_obj TFGridFarmer
}

pub fn new(twinid int, mut tfgrid &TFGrid) Farmer{

	//TODO
	
	mut farmer := Farmer{}
	farmer.twin = twin

	//get object from TFGrid, add to tfgrid_obj

	return farmer
}


fn (mut farmer Farmer) todefine_what_we_need() bool{
	//
}