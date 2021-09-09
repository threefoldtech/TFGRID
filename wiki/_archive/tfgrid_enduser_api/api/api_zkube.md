# api_zkube

!!!include:primitive_depl_

## Request

```golang
pub struct ZKube {
pub mut:
	reservation_id	int
	name			  string				//unqiue name per zdeployment, optional
    kybetype          KubeType
	network 		  ZmachineNetwork
	compute_capacity  ComputeCapacity
	mounts  		 []ZMachineMount        //needed?
	entrypoint		  string 				//how to invoke that in a vm?, needed?
	env         	  map[string]string 	//environment for the zmachine, needed for kube?
}

pub struct ZmachineNetwork{
pub mut:
	public_ip		 []string
	interfaces       []ZNetworkInterface
	planetary		 bool
}

pub struct ZNetworkInterface{
pub mut:
	network          string				//WHAT DOES THIS MEAN, please describe TODO:
	ip               string				//what is relation with public_ip?
}

pub struct ComputeCapacity {
pub mut:
	// cpu cores, minimal 10 cpu_centi_core
	// always reserved with overprovisioning of about 1/4-1/6
	// 1 = 1/100 of core
	cpu u16
	// memory in mbytes
	// always reserved
	memory u16
}


pub enum KubeType{
	master
	node
}

```

### Arguments

#### flist

- is url to custom flist, is optional
- if not used then is base flist as provided by ThreeFold in line with chosen vmtype

#### VMType

- This defines how a machine is booted, starting from which kernel.
- Its up to the user of the system to make sure that the flist used is compatible with the VMType

#### IP / public_ip

> TODO: ...

#### network

> TODO: ...

#### ZMachineMount

- name need to be as used in [api_zmount](api_zmount)


## Response Deployment

```golang
// response of the deployment
pub struct ZmachineResult {
pub mut:
	ip      string
}
```

!!!include:primitive_remarks_