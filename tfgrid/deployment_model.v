module tfgrid
import crypto.md5

pub struct Deployment {
pub mut:
	deployment_items       []DeploymentItem
	//md5 hash of the concatenation of the deployment items (see implementatio)
	//this string will be signed by the signers
	signature_hash 		    string
	signature_requirement	SignatureRequirement

}

//fills in all variables and make sure all is good so the object can be submmitted to a Zero-OS
pub fn (mut deployment Deployment) submit(){

	deployment.signature_hash = deploymentsignature_hash()

}

fn (mut deployment Deployment) zdbs_get () []ZDB{
	//walk over json\s, fill in ZBD objects
	return []ZDB{}

}


fn (mut deployment Deployment) containers_get () []Container{
	//walk over json\s, fill in Container objects
	return []Container{}

}



fn (mut deployment Deployment) signature_hash () string{
	out := []string()
	for item in deployment.deployment_items{
		out << item.category
		out << item.json_data
		out << "$expiration"
	}
	return md5.hexhash(out.join("\n"))
}

pub struct DeploymentItem {
pub mut:
	category		 Category
	json_data        string
	//in epoch format
	//when the full workload will stop working
	expiration int

}

enum Category {
	container Container
	zdb ZDB
	//TODO:
}

pub struct SignatureRequirement {
pub mut:
	// the requests which can allow to get to required quorum
	signature_requests []SignatureRequest
	// minimal weight which needs to be achieved to let this workload become valid
	weight_required int
	signatures      []Signature
}

pub struct SignatureRequest {
pub mut:
	// unique name as used in TFGrid DB
	twin_id int
	// if put on required then this twin_id needs to sign
	required bool
	// signing weight
	weight int
}

pub struct Signature {
pub mut:
	// unique name as used in TFGrid DB
	twin_id int
	// signature (done with private key of the twin_id)
	signature string
}
