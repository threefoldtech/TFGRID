module zos

import crypto.md5


pub struct SignatureRequest {
pub mut:
	// unique id as used in TFGrid DB
	twin_id int
	// if put on required then this twin_id needs to sign
	required bool
	// signing weight
	weight int
}

// Challenge computes challenge for SignatureRequest
pub fn(request SignatureRequest) challenge() string {
	mut out := []string{}
	out << '$request.twin_id'
	out << '$request.required'
	out << '$request.weight'

	return out.join('')
}

pub struct Signature {
pub mut:
	// unique id as used in TFGrid DB
	twin_id int
	// signature (done with private key of the twin_id)
	signature string
}


pub struct SignatureRequirement {
pub mut:
	// the requests which can allow to get to required quorum
	requests []SignatureRequest
	// minimal weight which needs to be achieved to let this workload become valid
	weight_required int
	signatures []Signature
}

// Challenge computes challenge for SignatureRequest
pub fn(mut requirement SignatureRequirement) challenge() string {
	mut out := []string{}

	for request in requirement.requests {
		out << request.challenge()
	}

	out << '$requirement.weight_required'
	return out.join('')
}



// deployment is given to each Zero-OS who needs to deploy something
// the zero-os'es will only take out what is relevant for them
// if signature not done on the main Deployment one, nothing will happen
pub struct Deployment {
pub mut:
	// increments for each new interation of this model
	// signature needs to be achieved when version goes up
	version int = 1
	// the twin who is responsible for this deployment
	twin_id u32
	// each deployment has unique id (in relation to originator)
	contract_id u64
	// when the full workload will stop working
	// default, 0 means no expiration
	expiration i64
	metadata string
	description string

	// list of all worklaods
	workloads []Workload

	signature_requirement SignatureRequirement
}


pub fn (mut deployment Deployment) challenge() string {
	mut out := []string{}
	out << '$deployment.version'
	out << '$deployment.twin_id'
	out << '$deployment.metadata'
	out << '$deployment.description'
	out << '$deployment.expiration'
	for mut workload in deployment.workloads {
		out << workload.challenge()
	}
	return out.join('')
}

// ChallengeHash computes the hash of the challenge signed
// by the user. used for validation
pub fn(mut deployment Deployment) challenge_hash() string {
	return md5.hexhash(deployment.challenge())
}
