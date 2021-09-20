# Getting Started

Here you'll find all of the information you need to create your first deployment on ThreeFold Grid 3.0 using Terraform. We'll walk through how to setup a wallet and Twin on TF Chain, how to install Terraform, and how to use Terraform to provision a basic virtual machine.

Please note that for now our Terraform plugin is only supported for Linux and MacOS. Windows support is planned for the future.

Steps:

- Install and configure Yggdrasil
- Create wallet and twin on TF Chain
- Install Terraform
- Deploy example Terraform file


## TERRAFORM Getting Started


### Deployment Examples

Several example deployment files are available on the [Terraform plugin Github repository](https://github.com/threefoldtech/terraform-provider-grid). Either clone the repo to get the whole set, or just copy the contents of one that interests you into a file on your local machine.

For more information about the structure and details of these files, see [this documentation](https://gist.github.com/xmonader/c46b0b7d3923df75889f6bc5322ad6d6).

### Specifying Mnemonic and Twin ID

The plugin will need your mnemonic seed phrase and twin ID in order to register deployments for you on TF Chain. There are two ways to do this: with environment variables and within the deployment file.

#### Environment Variables

Using environment variables is convenient, as it will cover all deployments on your local system and allow for running the examples without editing the deployment files. Run these commands, replacing your details where applicable:

```
export TWIN_IP=X
export MNEMONICS="... ... ..."
```

#### In Deployment Files

Place the mnemonic in the Terraform file, within the provider section, like this:

```
provider "grid" {
    twin_id = X
    mnemonics = "... ... ..." 
}
```

## WORKING WITH DEPLOYMENTS

We're now ready to create a deployment. Navigate in a terminal the the directory where your deployment file is located, and run:

`terraform init && terraform apply -parallelism=1`

If everything goes well, you'll see the output specified for the deployment. In our examples, this includes the Wireguard configuration and IP addresses assigned to the VMs. You can use this to establish a connection to the private overlay network containing your workloads and then interact with them.

### Destroy
Once you're done with the deployment, you can destroy it to free up those resources and stop the billing process. While the tokens on devnet are free, we do ask you to be mindful of how much capacity you're using for your testing, as we have a limited number of nodes on Grid 3.0 at this point.

To destroy your deployment, use:

`terraform destroy -parallelism=1`

### Update
It's also possible to update a deployment, by adding or removing some elements. Once the deployment file is changed, running ```terraform apply``` again will instruct Terraform to adjust the state of the deployed workloads to match the new specification in the file.

## TROUBLESHOOTING

`Error: failed to create contract: failed to create contract: failed to get account: account not found`

This could mean that your wallet doesn't have enough tokens. Check your wallet and top up if needed.