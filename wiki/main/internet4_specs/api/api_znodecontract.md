## API ZNodeContract

Is a contract for reservations which are linked to one specific node.

- a zdeployment is a combination of zreservations
- a znodecontract is also a combination of zreservations but linked to one specific 3node
    - its called a contract, because its an agreement between a 3node and a grid_user who wants to deploy a workload

!!!include:primitive_depl_


```golang

pub struct ZNodeContract {
pub mut:
    //unique id as given by TFGrid DB 
    id                   int  
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