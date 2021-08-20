//can represent person, company, ...
// anyone using or operating on the TFGrid
pub struct TFGridEntity {
pub mut:
	//to define version of schema used
    version int = 1
	// incremental ID as given by Substrate
    id int
    name string
	//SubstrateAccountID = links to wallet as owned by the entity (company or person)
    account_id string
	// ISO 3166-1 2 letter code
    country string
	// name of a city
    city string
}

fn example(){
	return GridEntity{
		id: 999
		name: "Some Name"
		address: "5FX45JeA5Z1F4fJBJwyWcZvyi7XU51ggqJREjM2e4wYRiuj6"
		country: "BE"
		city: "Ghent"
	}
}

