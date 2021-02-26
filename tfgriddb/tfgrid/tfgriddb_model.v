
module tfgrid

//as registered on the TFGrid DB
//need the data models here
pub struct TFGridEntity{
	id u32 [json: entityId]
	name string [json: name]
	grid_version u32 [json: gridVersion]
	country_id u32 [json: countryId]
	city_id u32 [json: cityId]
}

pub struct TFGridTwin{
	id u32 [json: twinId]
	ip string [json: ip]
	grid_version u32 [json: gridVersion]
	address string [json: address]
}

pub struct TFGridNode{
	id u32 [json: nodeId]
	farm_id u32 [json: farmId]
	grid_version string [json: gridVersion]
	country_id u32 [json: countryId]
	city_id u32 [json: cityId]
	address string [json: address]
	resources Resources [json: resources]
	location Location [json: location]
	pubkey string [json: pubKey]
}

pub struct Resources {
	hru u32
	sru u32
	cru u32
	mru u32
}

pub struct Location {
	longitude string
	latitude string
}

pub struct TFGridFarmer{
	id u32
	twin_id u32 [json: twinId]
	grid_version u32 [json: gridVersion]
	name string
	country_id u32 [json: countryId]
	city_id u32 [json: cityId]
	pricing_policy_id u32 [json: pricingPolicyId]
}