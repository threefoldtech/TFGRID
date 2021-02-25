module tfgrid

pub struct Container {
pub mut:
	flist       string
	hub_url     string
	env         map[string]string
	secretenv   map[string]string
	entrypoint  string
	interactive bool
	mounts      []Mount
	network     Member
	capacity    ContainerCapacity
	logs        []Logs //what is this? Should not be in an object like this. QUESTION:
	stats       []Stats //what is this? QUESTION:
}

pub struct ContainerCapacity {
pub mut:
	//cpu cores, minimal 10 cpu_centi_core
	cpu_centi_core u32
	//memory in MB, minimal 100 MB
	memory_mb u16
	disk_type string //enum TODO
	//disk size in MB, min 100 MB
	disk_size_mb u64
}

pub struct Member {
pub mut:
	network_id   string
	ips          []string
	public_ip6   string
	yggdrasil_ip string
}


pub struct Mount {
pub mut:
	volume_id  string
	mountpoint string
}

pub struct Logs {
pub mut:
	logs_type string   [json: 'type']
	data      LogsData
}

pub struct LogsData {
pub mut:
	stdout        string
	stderr        string
	secret_stdout string
	secret_stderr string
}

pub struct Stats {
pub mut:
	stats_type string [json: 'type']
	endpoint   string
}

pub struct ContainerResult {
pub mut:
	id    string
	ipv6  string
	ipv4  string
	ipygg string
}
