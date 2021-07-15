import zos
import threefoldtech.rmb.client
import despiegk.crystallib.redisclient

import json

fn main() {
	mut zmount := zos.Zmount{
		size: 1024*1024*10
	}

	mut workload := zos.Workload{
		version: 1,
		name: "zmountiaia",
		type_: zos.workload_types.zmount,
		data: zmount,
		metadata: "",
		description: "",
		acl: [],
	}

	// println(json.encode(workload))

	// mut mb :=  client.MessageBusClient{
	// 	client: redisclient.connect('localhost:6379') or { panic(err) }
	// }

	// mut msg := client.prepare("zos.statistics.get", [2], 0, 2)
	// payload := "abc"
	// mb.send(msg,payload)
	// response := mb.read(msg)
	// println("Result Received for reply: $msg.retqueue")
	// for result in response {
	// 	println(result)
	// 	println(result.data)
	// }
}
