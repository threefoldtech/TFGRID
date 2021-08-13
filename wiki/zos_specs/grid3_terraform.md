# Grid provider for terraform
 - A resource, and a data source (`internal/provider/`),
 - Examples (`examples/`) 
## Requirements

-	[Terraform](https://www.terraform.io/downloads.html) >= 0.13.x
-	[Go](https://golang.org/doc/install) >= 1.15

## Building The Provider

Note: please clone all of the following repos in the same directory
- clone github.com/threefoldtech/zos  (switch to master-3 branch)
- Clone github.com/threefoldtech/tf_terraform_provider (deployment_resource branch)
- Enter the repository directory

```bash
go get
mkdir -p  ~/.terraform.d/plugins/threefoldtech.com/providers/grid/0.1/linux_amd64
go build -o terraform-provider-grid 
mv terraform-provider-grid ~/.terraform.d/plugins/threefoldtech.com/providers/grid/0.1/linux_amd64
```


## example deployment


```
terraform {
  required_providers {
    grid = {
      version = "0.1"
      source  = "threefoldtech.com/providers/grid"
    }
  }
}

provider "grid" {}


resource "grid_deployment" "d1" {
  node = 2
  disks {
    name = "mydisk1"
    size = 2
    description = "this is my disk description1"
    
  }
  disks {
    name = "mydisk2"
    size=2
    description = "this is my disk2"
  }
  vms {
    name = "vm1"
    flist = "https://hub.grid.tf/tf-official-apps/base:latest.flist"
    cpu = 1
    memory = 2048
    entrypoint = "/sbin/zinit init"
    mounts {
      disk_name = "mydisk1"
      mount_point = "/opt"
    }
    mounts {
      disk_name = "mydisk2"
      mount_point = "/test"
    }
    env_vars {
      key = "SSH_KEY"
      value = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTwULSsUubOq3VPWL6cdrDvexDmjfznGydFPyaNcn7gAL9lRxwFbCDPMj7MbhNSpxxHV2+/iJPQOTVJu4oc1N7bPP3gBCnF51rPrhTpGCt5pBbTzeyNweanhedkKDsCO2mIEh/92Od5Hg512dX4j7Zw6ipRWYSaepapfyoRnNSriW/s3DH/uewezVtL5EuypMdfNngV/u2KZYWoeiwhrY/yEUykQVUwDysW/xUJNP5o+KSTAvNSJatr3FbuCFuCjBSvageOLHePTeUwu6qjqe+Xs4piF1ByO/6cOJ8bt5Vcx0bAtI8/MPApplUU/JWevsPNApvnA/ntffI+u8DCwgP"
    }

  }
}

```

## Using the provider

to create your twin please check [polka_grid](polka_grid)

```bash
./msgbusd --twin <TWIN_ID> #run message bus with your twin id
cd examples/resources
export MNEMONICS="<mnemonics workds>"
export TWIN_ID="<your twin id>"
terraform init && terraform apply
```
## Destroying deployment
```bash
terraform destroy
```
