// ssd mounts under zmachine


module zosreq

// ONLY possible on SSD
pub struct ReqZmount {
pub mut:
	// name unique per deployment, re-used in request & response
	name string
	// size in MB
	// is permanent diskspace as	
	size u32 //mb	

}


