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

#### peer
```
resource "peer" "p1" {
    private_key = "..."
    public_key = "..."

}

```
#### znet

```
resource "znet" "network1" {
    name = "network1"
    subnet = "192.168.0.0/16"
    peers = ["p1"]
}
```
### Disk
```
resource "zmount" "mydisk" {
    name = "mydisk"
    size = 1024 * 1024 * 50 
}
```

### ZDB

```
resource "zdb" "z1" {
    name = "z1"
    namespace = ".."
    password = ""
    size = 50*1024*1024
    zdb_mode = "user, seq"..
    disk_type = "hdd" or "ssd" # let's check the set type in terraform
    public = true 
}
```

### Zmachine

```
resource "zmachine" "m1" {
    name = "m1"
    flist = "https://hub.grid.tf/official-apps/ubuntu20.04.flist"
    network = "network1"
    zmounts = [{mydisk=/mnt/mydisk}]
    compute_capacity = {
        cpu = ...
        memory = ...
    }
    entrypoint = "..." 
    env = {
        key1 = value1
        key2 = value2
    }
    public_ip_name = ".."
    planetary = true
    private_nets = [{
        znet_name = "network1"
        ip = "192.168.12.1"
    }]
} 
```

### K8s

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
        }
    }
}
```

## Deployment

### creating
```
resource "deployment" "d1" {
    resources = ["mydisk", "network1", "m1"]
    
}

```
dispatching the deployment object to `zos.deployment.deploy` of the node 

## updating 

```
resource "zmount" "mydisk" {
    size = 1024 * 1024 * 100
}
```
- updated from 50 to 100
- the version of the workload needs to get updated internally
- the version of the deployment needs to get updated internally

dispatching the updated deployment object to `zos.deployment.update` of the node 