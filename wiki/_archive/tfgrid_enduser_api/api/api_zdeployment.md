## API ZDeployment

> roadmap: full implementation for TFGrid 3.1.x, this is suggestion only

!!!include:primitive_depl_


```golang

pub struct ZDeployment {
pub mut:
    //unique id as given by TFGrid DB for a solution (is autoincrement)
    id                   int  
    //optional
	name				 string
    //can be used to describe what the reservation is about
    //useful for multisignature
	description string
    reservations []ZReservationLink
}

// is a remote wireguard client which can connect to this node
pub struct ZReservationLink {
pub mut:
    //unique id as given by TFGrid DB for a reservation (is autoincrement)
	id int
    //can be used to describe what the reservation is about
    //useful for multisignature
	description string
    //hash which uniquely identifies the reservation
    hash string
}

// describes signature for the solution
pub struct Signature {
pub mut:
	id int
    twinid int
    signature string
    state SignatureState
    signature_date int //epoch
}

pub enum SignatureState{
    init
    requested
    signed
}


```

> TODO: need to describe how this needs to be used

!!!def alias:api_zdeployment