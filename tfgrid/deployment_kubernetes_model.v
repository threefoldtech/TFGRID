module tfgrid

pub struct Kubernetes {
pub mut:
	size          u16
	networkid     string
	ip            string
	clustersecret string
	masterips     []string
	sshkeys       string
	publicip      string
	// plainclustersecret
}

pub struct KubernetesResult {
pub mut:
	id string
	ip string
}
