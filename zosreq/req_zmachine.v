module zosreq

pub struct ReqZmachine {
pub mut:
	// name unique per deployment, re-used in request & response
	name              string
	networkinterfaces []NetworkInterface
	capacity          ComputeCapacity
	log_destinations  []LogDestination
	stat_destinations []StatDestination
	sshkeys           []string
	flist             string // if full url means custom flist meant for containers, if just name should be an official vm
	mode			  ZMachineMode	
	enable_corex	  bool   // used to be called interactive. enables corex or not
	env         	  map[string]string //environment for the zmachine
	secretenv         map[string]string
	hub_url			  string
	entrypoint		  string //how to invoke that in a vm?
	mounts  		 []Mount
}

enum ZMachineMode {
	container 
	vm
}


pub struct Mount {
	pub mut:
		zmount_name string
		mountpoint string
}




// response of the deployment
pub struct ResZMachine {
pub mut:
	// name unique per deployment, re-used in request & response
	name         string
	public_ipv4 string[]
	public_ipv6 string[]
	private_ipv6 string
	pan_ip6      string
}
