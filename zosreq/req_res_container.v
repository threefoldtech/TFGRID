module zosreq

pub struct ReqContainer {
pub mut:
	// name unique per deployment, re-used in request & response
	name              string
	flist             string
	hub_url           string
	env               map[string]string
	secretenv         map[string]string
	entrypoint        string
	corex_enabled     bool
	mounts            []ReqVolumeMount
	networkinterfaces NetworkInterfaces
	capacity          ComputeCapacity
	log_destinations  []LogDestination
	stat_destinations []StatDestination
}

pub struct ReqVolumeMount {
pub mut:
	// corresponds with name as given on volume level
	// see ReqVolume.name
	volume_name string
	// mountpoint in container e.g. /mnt/1
	mountpoint string
}

// response of the deployment
pub struct ResContainer {
pub mut:
	// name unique per deployment, re-used in request & response
	name         string
	private_ipv6 string
	pan_ip6      string
}
