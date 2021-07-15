module zos
import json

pub struct WorkloadTypes {
pub:
	zmachine string = "zmachine"
	zmount string = "zmount"
	network string = "network"
	zdb string = "zdb"
	ipv4 string = "ipv4"
}

pub const workload_types = WorkloadTypes{}

type WorkloadType = string

pub enum ResultState {
	error
	ok
	deleted
}

pub fn challenge(data string, type_ string) ?string {
	match type_ {
		workload_types.zmount {
			mut w := json.decode(Zmount, data)?
			return w.challenge()
		}

		workload_types.zdb {
			mut w := json.decode(Zdb, data)?
			return w.challenge()
		} 
		workload_types.zmachine {
			mut w := json.decode(Zmachine, data)?
			return w.challenge()
		}

		// workload_types.zmount {
		// 	mut w := json.decode(Zmount, data)
		// 	return w.challenge()
		// }

		// workload_types.zmount {
		// 	mut w := json.decode(Zmount, data)
		// 	return w.challenge()
		// }
		else {
			return ""
		}
	}
}

pub enum Right {
	restart
	delete
	stats
	logs
}

// Access Control Entry
pub struct ACE {
	// the administrator twin id
	twin_ids []int
	rights   []Right
}


pub struct DeploymentResult {
pub mut:
	created i64
	state ResultState
	error string
	data string [raw] // also json.RawMessage
}


pub struct Workload {
pub mut:
	version int
	// unique name per Deployment
	name     string
	type_    WorkloadType  [json:"type"]
	// this should be something like json.RawMessage in golang
	data     string [raw] // serialize({size: 10}) ---> "data": {size:10},

	metadata string
	description string

	// list of Access Control Entries
	// what can an administrator do
	// not implemented in zos
	// acl []ACE

	result string [raw]
}


pub fn (mut workload Workload) challenge() string{
	mut out := []string{}

	out << '$workload.version'
	out << '$workload.type_'
	out << '$workload.metadata'
	out << '$workload.description'
	out <<  challenge(workload.data, workload.type_) or {
		return out.join('')
	}

	return out.join('')
}

type WorkloadData = Zmount | Zdb | Zmachine | ZNet
type WorkloadDataResult = ZmountResult | ZdbResult | ZmachineResult

// pub fn(mut w WorkloadData) challenge() string {
// 	return w.challenge()
// }
