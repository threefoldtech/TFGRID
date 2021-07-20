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
    //useful for multisignature, optional
	description         string
    expiration          int
}


```

> TODO: need to describe how this needs to be used

> TODO: question, how is security around this, how do we make sure only certain people can update, where is link to account info?

!!!def alias api_zreservation, api_reservation