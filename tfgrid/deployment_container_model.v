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
	logs        []Logs
	stats       []Stats
}
