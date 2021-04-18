module zosreq

pub struct NetworkInterfaces {
pub mut:
	// name unique per deployment, re-used in request & response
	name string
	// links to ReqZOSNetwork name, network on which this interface is connected
	network_name string
	// ip4 need to be in ZOS Network
	// 		e.g. ["192.168.10.20"]
	// 		no mask
	ip4_private   string
	ip4_public    []string
	ip6_public    []string
	ip6_planetary bool
}

// ZERO-OS will check if the ip address requested really belongs to use
