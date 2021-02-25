
module tfgrid

//as registered on the TFGrid DB
//need the data models here
pub struct TFGridEntity{
	id string [json: entityId]
	name string [json: name]
	grid_version string [json: gridVersion]
	country_id string [json: countryId]
	city_id string [json: cityId]
}

pub struct TFGridTwin{
	id string [json: twinId]
	ip string [json: ip]
	grid_version string [json: gridVersion]
	address string [json: address]
}

pub struct TFGridNode{
	id u32
}

pub struct TFGridFarmer{
	id u32
	name string
}