module tfgrid

pub struct ZDB {
pub mut:
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

pub struct ZDBResult {
pub mut:
	namespace string
	ips       []string
	port      u32
}

pub enum ZDBMode {
	seq
	user
}
