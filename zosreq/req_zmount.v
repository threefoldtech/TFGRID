// ssd mounts under zmachine


module zosreq

// ONLY possible on SSD
pub struct ReqZmount {
pub mut:
	size u64 // bytes
}

pub struct ResZmount {
pub mut:
	volume_id string
}
