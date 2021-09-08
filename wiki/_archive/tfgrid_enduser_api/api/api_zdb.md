# API ZDB

!!!include:primitive_depl_

```golang

pub struct ZDB {
pub mut:	
	reservation_id	int
	name			  string				//unqiue name per zdeployment, optional	
	namespace 		string
	password  		string
	// size in mbytes
	size      		u16
	mode      		ZDBMode
	disktype 		DiskType
	public    		bool
}

pub enum ZDBMode {
	seq
	user
}

pub enum DiskType {
	hdd
	ssd
}



```

!!!include:primitive_remarks_