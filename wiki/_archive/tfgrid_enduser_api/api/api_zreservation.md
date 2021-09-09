## API ZReservation

!!!include:primitive_depl_

```golang

pub struct ZReservation {
pub mut:
    //unique id as given by TFGrid DB for a reservation (is autoincrement)
    id                   int  
    //optional
	name				 string
    //can be used to describe what the reservation is about
    //useful for multisignature, optional, not done now
	description         string
    expiration          int
}


```

!!!def alias api_zreservation, api_reservation