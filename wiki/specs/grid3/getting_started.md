# Getting Started

Here you'll find all of the information you need to create your first deployment on ThreeFold Grid 3.0 using Terraform. We'll walk through how to setup a wallet and Twin on TF Chain, how to install Terraform, and how to use Terraform to provision a basic virtual machine.

Please note that for now our Terraform plugin is only supported for Linux and MacOS. Windows support is planned for the future.

Steps:

- Install and configure Yggdrasil
- Create wallet and twin on TF Chain
- Install Terraform
- Deploy example Terraform file

## YGGDRASIL

### Install

Yggdrasil is necessary for communication between your local machine and the nodes on the Grid that you deploy to. Binaries and packages are available for all major operating systems, or it can be built from source. Find installation instructions here.

After installation, you'll need to add at least one publicly available peer to your Yggdrasil configuration file. By default on Unix based systems, you'll find the file at `/etc/yggdrasil.conf`. To find peers, check this site, which compiles and displays the peer information available on Github.

Add peers to your configuration file like so:

```
Peers: ["PEER_URL:PORT", "PEER_URL:PORT", ...]
```

### Run

#### Linux

On Linux with `systemd`, Yggdrasil can be started and enabled as a service, or run manually from the command line:

```
sudo yggdrasil -useconffile /etc/yggdrasil.conf
```

#### MacOS
The MacOS package will automatically install and start the `launchd` service. After adding peers to your config file, restart Yggdrasil by stopping the service (it will be restarted automatically):

```
sudo launchctl stop yggdrasil
```

### Test Connectivity
To ensure that you have successfully connected to the Yggdrasil network, try loading the site in your browser:

```
http://[319:3cf0:dd1d:47b9:20c:29ff:fe2c:39be]/
```

### Firewalls
Creating deployments on the Grid also requires that nodes can reach your machine as well. This means that a local firewall preventing inbound connections will cause deployments to fail.

#### Linux

On systems using `iptables`, check:
```
sudo ip6tables -S INPUT
```

If the first line is `-P INPUT DROP`, then all inbound connections over IPv6 will be blocked. To open inbound connections, run:

```
sudo ip6tables -P INPUT ACCEPT
```

To make this persist after a reboot, run:

```
sudo ip6tables-save
```

If you'd rather close the firewall again after you're done, use:

```
sudo ip6tables -P INPUT DROP
```

#### MacOS

The MacOS system firewall is disabled by default. You can check your firewall settings according to instructions here.

### Get Yggdrasil IP
Once Yggdrasil is installed, you can find your Yggdrasil IP address using this command on both Linux and Mac:

```
yggdrasil -useconffile /etc/yggdrasil.conf -address
```

You'll need this address when registering your twin on TF Chain in the next step.

## Redis

For now, Redis is an external dependency of the protocol used to communicate with nodes on the Grid.

### Install

#### Linux
If you don't find Redis in your distro's package manager, check the [Redis downloads](https://redis.io/download) page for source code and installation instructions.

#### MacOS
Homebrew can be used to install Redis, as follows:

```
brew update
brew install redis
```

Alternatively, it can be built from source, using the same download page linked for Linux above.

### Run
Launch the Redis server with:

```
redis-server
```

## TF-Chain

For deployments, you'll need a TF Chain acount and a twin registered. Visit [this page](https://vgrid.staging2.threefold.io/#/vgrid__grid_substrate_getting_started) for instructions. You'll need both your mnemonic phrase and Twin id to pass to the Terraform plugin.

Important notes:

You must choose `ed25519` as the "crypto type" when setting up your account
When funding your wallet from the provided faucet accounts, you can transfer more than the shown balance of those accounts. Take a few thousand tokens to make sure you don't run out while testing
The guide advises to find your twin ID by checking the `twinID()` method. However, this will only correspond to your ID until a new twin is created and the value is incremented. To make sure you're seeing the ID associated with your account, use `twinIdByAccountID(AccountId)` instead, and select your account name from the drop down.

## TERRAFORM

### Install
Get Terraform from the [download page](https://www.terraform.io/downloads.html) on the official site, or install using you system's package manager.

There's no need to specifically install the ThreeFold Terraform plugin. Terraform will automatically load it from an online directory according to instruction within the deployment file.

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