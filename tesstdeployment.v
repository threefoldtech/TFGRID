import zosreq1
import threefoldtech.rmb.client
import despiegk.crystallib.redisclient

fn main() {
	// mut testzmount := zosreq1.ReqZmount{
	// 	size: 1024*1024*10
	// }

	mut mb :=  client.MessageBusClient{
		client: redisclient.connect('localhost:6379') or { panic(err) }
	}

	mut msg := client.prepare("zos.statistics.get", [2], 0, 2)
	payload := "abc"
	mb.send(msg,payload)
	response := mb.read(msg)
	println("Result Received for reply: $msg.retqueue")
	for result in response {
		println(result)
		println(result.data)
	}
}