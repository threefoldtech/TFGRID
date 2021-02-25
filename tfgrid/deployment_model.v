module tfgrid
import crypto.md5

//deployment is given to each Zero-OS who needs to deploy something
//the zero-os'es will only take out what is relevant for them
//if signature not done on the main Deployment one, nothing will happen
pub struct Deployment {
pub mut:
	//the twin who is responsible for this deployment
	originator_twin_id 			int
	//each deployment has unique id (in relation to originator)
	originator_deployment_id 	int
	//when the full workload will stop working
	//default, 0 means no expiration
	expiration 		 int
	//list of all deployments
	deployment_items       []DeploymentItem
	//md5 hash of the concatenation of the deployment items (see implementatio)
	//this string will be signed by the signers
	signature_hash 		    string
	signature_requirement	SignatureRequirement
	// information to allow digital twin's to pay for this workload
	// can be more than one, the farmer bot will try all payment providers untill payment done
	payment_providers		[]PaymentRequest

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
	out << "$deployment.expiration"
	for item in deployment.deployment_items{
		out << item.category
		out << item.json_data
		out << "$item.node_id"
	}
	return md5.hexhash(out.join("\n"))
}

pub struct DeploymentItem {
pub mut:
	node_id			 int
	category		 Category
	json_data        string
	//in epoch format
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


pub struct PaymentRequest{
	// unique name as used in TFGrid DB
	twin_id int
	// secret is encrypted by means of public key of the twin who needs to do the payment 
	// that secret is used to let the paying digital twin verify if payment is valid
	// can be empty, which means there is no secret, payment will done if payment processor is willing to pay to that farmer
	secret string
}
