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
	category          VMOSType
	flist             string // if full url means custom flist meant for containers, if just name should be an official vm
	mode			  ZMachineMode	
	enable_corex	  bool   // used to be called interactive. enables corex or not
	env         map[string]string //environment for the zmachine
	hub_url			  string
	entrypoint		  string //how to invoke that in a vm?
	mounts  		[]Mount
	metadata	map[string]string //can be used to trigger k8s flow? or have kubernetes primitive still?
}


enum VMOSType {
	ubuntu_20_04
}

enum ZMachineMode {
	container 
	vm
	k8s // this in zos will ignore the flist var?
}


pub struct Mount {
	pub mut:
		volume string
		mountpoint string
}

