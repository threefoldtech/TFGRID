module tfgrid

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
