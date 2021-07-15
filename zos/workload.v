module zos
import x.json2

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


// Access Control Entry
pub struct ACE {
	// the administrator twin id
	twin_ids []int
	rights   []Right
}

enum Right {
	restart
	delete
	stats
	logs
}

pub struct DeploymentResult {
pub mut:
	created i64
	state ResultState
	error string
	data WorkloadDataResult // also json.RawMessage
}


pub struct Workload {
pub mut:
	version int
	// unique name per Deployment
	name     string
	type_    WorkloadType  [json:"type"]
	// this should be something like json.RawMessage in golang
	data     WorkloadData // serialize({size: 10}) ---> "data": {size:10},
	metadata string
	description string

	// list of Access Control Entries
	// what can an administrator do
	// not implemented in zos
	acl []ACE

	result WorkloadDataResult
}


pub fn (mut workload Workload) challenge() string{
	mut out := []string{}

	out << '$workload.version'
	out << '$workload.type_'
	out << '$workload.metadata'
	out << '$workload.description'
	out <<  workload.data.challenge()

	return out.join('')
}

type WorkloadData = Zmount | Zdb
type WorkloadDataResult = ZmountResult | ZdbResult

// pub fn(mut w WorkloadData) challenge() string {
// 	return w.challenge()
// }
