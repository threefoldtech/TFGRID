module main

import despiegk.crystallib.vredis2

fn command_ping(input vredis2.RedisValue, mut _ vredis2.RedisInstance) vredis2.RedisValue {
	if input.list.len > 1 {
		return vredis2.value_success(input.list[1].str)
	}

	return vredis2.value_success("PONG")
}

pub fn custom_handler(mut client vredis2.Redis, mut instance vredis2.RedisInstance, value vredis2.RedisValue) ?bool {
	mut h := []vredis2.RedisHandler{}

	h << vredis2.RedisHandler{command: "PING", handler: command_ping}

	command := value.list[0].str.to_upper()

	for rh in h {
		if command == rh.command {
			println("Process: $command")
			data := rh.handler(value, instance)
			client.encode_send(data)?
			return true
		}
	}

	// debug
	print("Error: unknown command: ")
	for cmd in value.list {
		print("$cmd.str ")
	}
	println("")

	err := vredis2.value_error("Unknown command")
	client.encode_send(err)?

	return false
}

fn main() {
	println("init")
	mut srv := vredis2.listen("0.0.0.0", 1234)?
	mut main := &vredis2.RedisInstance{
		executor: custom_handler
	}

	for {
		println("waiting")
		mut conn := srv.socket.accept() or { continue }
		go vredis2.new_client(mut conn, mut main)
	}
}
