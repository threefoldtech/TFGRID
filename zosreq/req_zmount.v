// ssd mounts under zmachine


module zosreq

pub struct ReqZmount {
pub mut:
	// name unique per deployment, re-used in request & response
	name string
	size u64 //mb	

}

