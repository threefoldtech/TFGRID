// todo OEM only later

module zosreq

// ONLY possible on SSD
pub struct ReqZDisk {
pub mut:
	// name unique per deployment, re-used in request & response
	name string
	// size in MB
	// is permanent diskspace as
	size u32
}
