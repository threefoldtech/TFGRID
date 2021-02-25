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
