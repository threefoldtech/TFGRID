module zosreq

pub struct ReqVM {
pub mut:
	// name unique per deployment, re-used in request & response
	name              string
	networkinterfaces []NetworkInterface
	capacity          ComputeCapacity
	log_destinations  []LogDestination
	stat_destinations []StatDestination
	sshkeys           []string
	category          VMOSType
}

enum VMOSType {
	ubuntu_20_04
}
