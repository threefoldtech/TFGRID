module tfgrid

pub struct ZDB {
pub mut:
	size      u64    // make enum
	mode      ZDBMode
	password  string
	disk_type string
	public    bool
	// plainpassword
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
