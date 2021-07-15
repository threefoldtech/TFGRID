import zos
import threefoldtech.rmb.client
import despiegk.crystallib.redisclient

import libsodium
import json
import time

fn main() {
	mut zmount := zos.Zmount{
		size: 1024*1024*10
	}

	mut workload := zos.Workload{
		version: 1,
		name: "zmountiaia",
		type_: zos.workload_types.zmount,
		data: json.encode(zmount),
		metadata: "zm",
		description: "zm test",
	}

	mut deployment := zos.Deployment{
		version: 1,
		twin_id: 17,
		expiration:  1626394539,//time.now().unix_time() + 11111,
		metadata: "zm dep",
		description: "zm test",
		workloads: [workload],
	}


	hash := deployment.challenge_hash()
	deployment.contract_id = 14

	mut secret := [byte(171), 101, 228, 213, 178, 56, 187, 250, 175, 19, 223, 79, 12, 92, 149, 56, 221, 186, 188, 41, 119, 82, 88, 84, 191, 11, 119, 28, 6, 131, 8, 40]!
	mut pubkey := [byte(57), 54, 233, 10, 99, 57, 243, 21, 198, 161, 135, 30, 247, 196, 32, 60, 11, 117, 172, 13, 183, 237, 253, 67, 222, 118, 37, 238, 241, 161, 194, 223]!
	key := libsodium.new_signing_key(pubkey, secret)

	println("deployment hash: $hash")
	deployment.sign(17, key)
	payload := json.encode(deployment)
	print("payload: $payload")
// 	mut mb :=  client.MessageBusClient{
// 		client: redisclient.connect('localhost:6379') or { panic(err) }
// 	}

// 	mut msg := client.prepare("zos.statistics.get", [2], 0, 2)
// 	mb.send(msg,payload)
// 	response := mb.read(msg)
// 	println("Result Received for reply: $msg.retqueue")
// 	for result in response {
// 		println(result)
// 		println(result.data)
// 	}
// }
}
