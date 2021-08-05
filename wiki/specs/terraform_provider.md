# Terraform integration

## provider initialization


```
provider "threefoldgrid" {
    mnemonics = "..."
    substrate_url = "..."
    twin_id = "..."
}
```
### environment variables
should be recognizable as Env variables too
- `GRID_MNEMONICS`
- `SUBSTRATE_URL`
- `TWIN_ID`

### credential file

```
provider "threefold" {
    creds_file = "..."
}

```

## primitives

### network

#### nodes
```
resource "node" "n1" {
    node_id = 3  ## substrate twin id

}

```
#### znet

```
resource "znet" "network1" {
    name = "network1" # remove if can be reused from the above  
    subnet = "192.168.0.0/16" 
}
NOTE: peers for this resource are all of the peers in the terraform file
```
### Disk
```
resource "zmount" "mydisk" {
    name = "mydisk"   # remove if can be reused from the above 
    size = 1024 * 1024 * 50 
    node = "n1"
}
```

### ZDB

```
resource "zdb" "z1" {
    name = "z1" # remove if can be reused from the above  
    namespace = ".." # should be generated randomly at first let's see 
    password = ""
    size = 50*1024*1024
    zdb_mode = "user, seq" ## check if enums can work here
    disk_type = "hdd" or "ssd" # let's check the set type in terraform
    public = true 
    node = "n1"
}
```
### IP Resource

```
resource "ip4" "myip" {
    node = "n1"
    ## created when submitted to the contract and then used as public_ip_name
}
```

should be added to the output.tf (data is stored on the contract and the node too)
### Zmachine

```
resource "zmachine" "m1" {
    name = "m1" # remove if can be reused same as above
    flist = "https://hub.grid.tf/official-apps/ubuntu20.04.flist" # can use this one as the default
    zmounts = [{mydisk=/mnt/mydisk}]
    compute_capacity = {
        cpu = 1 
        memory = 2 * 1024 * 1024 in bytes
    }
    entrypoint = "..." # default /sbin/zinit init
    env = {
        key1 = value1
        key2 = value2
    }
    public_ip_name = "myip"
    planetary = true
    private_nets = [{
        znet_name = "network1"
        ip = "192.168.12.1"
    }]
    node = "n1"
} 
```

### K8s

master & worker shouldn't be on the same node 
```
resource "kubernetes" "k1" {
    flist = "... or k3os"  
    machines {
        master = {
            name = "k1m1"
            env = {
                key1=val
            }
            public_ip_name = "..."
            private_nets = [{
                znet_name = "network1"
                ip = "192.168.12.5"
            }]
            node = n1
        }
        worker = {
            name = "k1m2"
            env = {
                key1=val
            }
            public_ip_name = "..."
            private_nets = [{
                znet_name = "network1"
                ip = "192.168.12.6"
            }]
            node = "n2"
        }
    }
}
```

## Deployment

deployment objects can be inferred from the defined resources



## updating 

```
resource "zmount" "mydisk" {
    size = 1024 * 1024 * 100
}
```
- updated from 50 to 100
- the version of the workload needs to get updated internally
- the version of the deployment needs to get updated internally
- update the hash in the contract (the contract id will stay the same)
  
dispatching the updated deployment object to `zos.deployment.update` of the node 