
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
	id string [json: nodeId]
	farm_id string [json: farmId]
	grid_version string [json: gridVersion]
	country_id string [json: countryId]
	city_id string [json: cityId]
	address string [json: address]
	resources Resources [json: resources]
	location Location [json: location]
	pubkey string [json: pubKey]
}

pub struct Resources {
	hru string
	sru string
	cru string
	mru string
}

pub struct Location {
	longitude string
	latitude string
}

pub struct TFGridFarmer{
	id u32
	name string
}