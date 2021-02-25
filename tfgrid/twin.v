module tfgrid

//our own digital twin

pub enum TwinState{
	ok
	error
	error_connection
	error_key
}

struct Twin{
mut pub:	
	// our own digital twin
	twin_id int	
	// planetary network addr of this twin (how registered on the global net)
	ipaddr6 Ipaddr6
	state TwinState
	tfgrid_obj TFGridTwin
}

pub fn new(twinid int, mut tfgrid &TFGrid) bool{

	mut twin := Twin{}

	//load the public key from the twin (through using your digital twin as proxy)
	//get the twin object from the TFGrid
	twin.tfgrid_obj = tfgrid.twin_get(twinid)

	//TODO: populate ipaddr

	//check we can reach that digital twin
	twin.ipaddr.ping()?
	//check a rest webservice on the digital twin (ping webservice)
	
	// do whatever we need to do

	//if ok

	twin.state = TwinState.ok

	return twin
}


//chech that the payload was signed with private key of this remote twin
//we do this by using their public key which comes from TFGrid DB
pub fn (mut twin Twin) verify(payload string)?{

}

//encrypt message using public key of the twin we are taking with
pub fn (mut twin Twin) encrypt(payload string)? string{

}

