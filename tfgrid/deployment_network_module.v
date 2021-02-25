module tfgrid

pub struct Network {
pub mut:
	name                     string
	network_iprange          string
	subnet                   string
	wg_private_key_encrypted string
	wg_listen_port           u16
	peers                    []Peer
}

pub struct Peer {
pub mut:
	subnet        string
	wg_public_key string
	allowed_ips   []string
	endpoint      string
}
