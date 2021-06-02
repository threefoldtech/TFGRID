module zosreq

pub struct ReqKubernetes {
pub mut:
	// name unique per deployment, re-used in request & response
	name string
	// not encrypted, because full workload is encrypted
	// plainclustersecret
	clustersecret string
	// ip address of the master for this cluster, if empty becomes master himself
	masterips         []string  // does this mean we will support HA k8s as primitive?
	networkinterfaces []NetworkInterface
	capacity          ComputeCapacity
	log_destinations  []LogDestination
	stat_destinations []StatDestination
	sshkeys           []string
	datastore_endpoint string
	disable_default_ingress bool
}
