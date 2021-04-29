module zosreq

pub struct ReqZDB {
pub mut:
	// name unique per deployment, re-used in request & response
	name string
	// name to be used for namespaces
	// in ZDB itself it will be $deploymentid_$name
	namespace string
	// size in MB
	size_mb   u32
	mode      ZDBMode
	password  string
	disk_type DiskType
	public    bool
}

enum DiskType {
	hd
	ssd
}

pub struct ResZDB {
pub mut:
	// name unique per deployment, re-used in request & response
	name      string
	namespace string
	ips       []string
	port      u32
}

pub enum ZDBMode {
	seq
	user
}
