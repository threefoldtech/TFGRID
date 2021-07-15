module zosreq

// pub struct NetworkInterfaces {
// pub mut:

// 	interfaces []NetworkInterface
// }

// ZERO-OS will check if the ip address requested really belongs to use (in phase 2)
pub struct ZMachineNetwork {
pub mut:
	// since public IPs to work has to
	// be wired in a certain way on the node.
	// a public ip can't be tight to an `interface`
	// since interface are alrady wired to carry traffic
	// from user private network. hence public IPs are
	// defined on the machine level. for each public IP
	// the node will create an interface.
	// Same for public IPv6 (not supported atm)

	// list of IP4 "reservations" on the deployment.
	// this not set to the IP valu, but the name of the
	// ip reservation. The ip then will get resolved from
	// the name
	ip4_public []string
	ip6_public []string

	ip6_planetary bool

	// each interface can be part of one and only one private
	// user network. hence only one IP on the interface is
	// possible and must belong to the network subent.
	interfaces []NetworkInterface
}

pub struct NetworkInterface {
pub mut:
	// links to ReqZnet name, network on which this interface is connected
	network_name string
	// ipv4 value as assigned by the user. this holds the actual IP
	// assigned from this network subnet which is valid on this node.
	ip4_private  string
}
