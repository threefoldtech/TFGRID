module tfgrid

pub struct IP4Net {
	subnet string
	mask_size u8
}

pub struct Network {
pub mut:
	// unique per deployment
	name string
	// unique nr for each network chosen, this identified private networks as connected to a container or vm or ...
	// corresponds to the 2nd number of a class B ipv4 address
	network_nr     int
	private_key    string
	wg_listen_port u16
	peers          []Peer
}

// network_new TODO:

fn (mut net Network) private_key_generate() ? {
}

pub struct Peer {
pub mut:
	subnet        string
	wg_public_key string
	allowed_ips   []string
	endpoint      string
}

pub struct NetworkBuilder {
mut:
	// node ids in the network mapped on their class C subnet that will be
	// deployed on them
	nodes: map[int]string
	access_points: map[int][]AccessPointConfig
	// TODO
}

struct AccessPointConfig {
	access_node: int
	subnet: string
	ipv4: bool
}

// add_node adds a new node to the network. The provided subnet will be installed
// on the node.
pub fn (mut nb NetworkBuilder) add_node(node_id: int, subnet string) NetworkBuilder {
	nb.nodes[node_id] = subnet
	return nb
}

// add_access adds a new access point in the network for external access (e.g.
// from your laptop). The node_id is the id of the node to connect to. The subnet
// is the subnet that will be routed externally (e.g. on your laptop). Ipv4 will
// force the access node enpoint to use an ipv4 connection (in case you don't
// have ipv6 available).
pub fn (mut nb NetworkBuilder) add_access(node_id: int, subnet: string, ipv4: bool) NetworkBuilder {
	nb.access_points[node_id] << AccessPointConfig {
		access_node: node_id,
		subnet: subnet,
		ipv4: ipv4
	}
	return nb
}

// buid the network, generating the appropriate Network structs to include in the
// workload, as well as the wireguard configs for the remote access
pub fn (nb NetworkBuilder) build() ?([]Network, []string) {
	// TODO: subnet verification
	// verify that all nodes to use as access point are also present as regular
	// node
	for node_id in nb.access_points {
		mut found := false
		for nid in nb.nodes {
			if node_id == nid {
				found = true
				break
			}
		}
		if !found {
			return error('Using a node as access point which is not part of the network')
		}
	}

	mut node_endpoints := map[int][]string {}

	for node_id in nb.nodes {
		endpoints := get_node_endpoints(node_id)?
		node_endpoints[node_id] = endpoints
	}

	// TODO: keygen needs bindings in wg tools, or curve25519 if we reimpl
	// generate keys
	mut node_keys := map[int]Keypair {}
	for node_id in nb.nodes {

	}
	// map access points based on subnet as this is known to be unique
	mut ap_keys := map[string]Keypair {}
	for _, v in nb.access_points {
		for node_id in v {
			// 
			// ap_keys[v.subnet] = 
		}
	}

	// For the following sections we need IP types to properly work
	// TODO: first connect external access as this is known to be point to point, and generate wg configs
	//
	// TODO: pick a random node with both ipv4 and ipv6 as routing node in case it is needed
	//
	// TODO: create mesh of all nodes. If one only has IPv6 and the other only IPv4, go over routing node
}

fn get_node_endpoints(node_id int) ?[]string {
	// TODO
	return error('get_node_endpoints not implemented')
}
