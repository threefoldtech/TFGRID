module tfgrid

// ONLY possible on SSD
pub struct Volume {
pub mut:
	// name unique per deployment
	// allows to address a volume per deployment
	name string
	// size in MB
	// is permanent diskspace as 
	size u32
}
