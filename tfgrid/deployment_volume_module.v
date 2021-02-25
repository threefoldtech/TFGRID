module tfgrid

pub struct Volume {
pub mut:
	size  u64
	vtype string [json: 'type']
}

pub struct VolumeResult {
pub mut:
	volume_id string
}
