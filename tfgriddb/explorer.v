module tfgrid

// logic needs to be here to fetch basic info from TFGrid DB

struct Explorer {
	ipaddr []string
}

fn explorer_new() ?Explorer {
	mut explorer := Explorer{
		ipaddr: ['11111']
	}

	// now add the ipaddresses in code which explorers can be reached

	return explorer
}

// TODO: will need methods here to use the https client
