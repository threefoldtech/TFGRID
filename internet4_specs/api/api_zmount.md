## ZMount API 


!!!include:primitive_depl_

reserve a mounted location onto an SSD

```golang

// always on SSD
pub struct Zmount {
pub mut:
	reservation_id	int
	name			  string				//unqiue name per zdeployment, optional
	size i16 // mbytes
}


```

- The name is unique per reservation_id


!!!include:primitive_remarks_