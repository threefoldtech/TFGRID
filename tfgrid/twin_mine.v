module tfgrid

//our own digital twin

enum MyTwinState{
	ok
	error
	connectionerror
}

struct MyTwin{
	// our own digital twin
	twin_id int	
	// planetary network addr of this twin (how registered on the global net)
	ipaddr6 Ipaddr6
	state MyTwinState
}

fn (mut twin MyTwin) init() bool{
	if twin.state != MyTwinState.ok{
		//check we can reach our own digital twin
		twin.ipaddr.ping()?
		//check a rest webservice on the digital twin (ping webservice)
		// do whatever we need to do
	}
}


//our own private key
struct MyTwinPrivateKey{
}

fn (mut key MyTwinPrivateKey) load(path string)?{
	//load private key from the filesystem
	//check its a valid one, remember on MyTwinPrivateKey
	if ! os.exists(path){
		return error("cannot find private key on $path")
	}

}


//could be its not strings we need to return but bytestrings? TODO:
fn (mut key MyTwinPrivateKey) sign(payload string)? string{

}

//chech that the payload was signed with our private key
fn (mut key MyTwinPrivateKey) verify(payload string)? bool{

}

//decrypt something send to us using our private key
fn (mut key MyTwinPrivateKey) decrypt(payload string)? string{

}

