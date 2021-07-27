## API ZNET

!!!include:primitive_depl_

Our ZNet technology uses wireguard as underling linux network technology (as part of linux kernel).

Following struct allows anyone

```golang

pub struct Znet {
pub mut:
	reservation_id	int
	name			  string				//unqiue name per zdeployment, optional
	// form: e.g. 192.168.0.0
	// is always a class B betwork
	subnet             	  string
	peers []Peer
}

// is a remote wireguard client which can connect to this node
pub struct Peer {
pub mut:
	// wireguard private key, curve25519
	private_key string
	// public key, curve25519 compatible with wireguard
	public_key string
}

```

> TODO: need to describe how this needs to be used


## ZOS free port 

- 


## Remarks

> TODO: need API endpoint on ZOS to find open ports
> TODO: are all required primitives in libsoldium in vlang, if yes point to how to use it

!!!include:primitive_remarks_