
# Test setup

Steps to deploy a test scenario using zos3, yggdrasil,polkadot.

## Create twin

### 1. Create account on substrate using polkadot

- Add the required [types in json format](https://github.com/threefoldtech/tfgrid-api-client/blob/master/types.json) to the [developer settings](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Fexplorer.devnet.grid.tf%2Fws#/settings/developer) in polkadot. *note: don't forget to save*
![](img/substrate_types.png)

- Click on `Add an account` in [polkadot accounts](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Fexplorer.devnet.grid.tf%2Fws#/accounts)
- Save the mnemonic seed in a safe place

- Click on `Advanced creation options` and select the keyword crypto type of **`Edwards (ed25519, alternative)`**
`
![](img/add_account_1.png)
- Add a name and password for your account (remember the password for future usage)
![](img/add_account_2.png)
![](img/add_account_3.png)
- Fund the account with test funds (Click on send funds from the account of Alice to your account name)
![](img/substrate_send_funds.png)

### 2. Setup yggdrasil (optional to obtain public Ipv6 address)

- download and install yggdrasil using the following [link](https://github.com/yggdrasil-network/yggdrasil-go/releases/tag/v0.4.0)
- Start it initially to init the configurations:

        systemctl start yggdrasil
    Or using

        yggdrasil -useconffile /etc/yggdrasil.conf
- Add the needed [peers](https://publicpeers.neilalexander.dev/) in the config file generated under Peers.

  **example**:

        Peers:
        [
        tls://54.37.137.221:11129
        ]

- Restart yggdrasil by

        systemctl restart yggdrasil


### 3. Create twin on substrate using polkadot

- Select the options to create the twin in [polkadot developer extrinsics](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Fexplorer.devnet.grid.tf%2Fws#/extrinsics)

  - Selected account -> your Account name

  - Extrinsic module to be submitted(from drop down menu) -> tfgridModule

  - Extrinsic method to be submitted -> createTwin(ip)

  - ip -> Ipv6 obtained from your yggdrasil
- Submit transaction and enter password selected when creating the account

![](img/substrate_create_twin.png)

- To get your twin ID, select the options required in [polkadot developer chainstate](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Fexplorer.devnet.grid.tf%2Fws#/chainstate) and click on the +
  - Module -> tfgridModule
  - Method -> twinID(): u32

![](img/substrate_twin_id.png)

## Start RMB (Reliable Message Bus)

- Clone the [RMB repo](https://github.com/threefoldtech/rmb)

- Run the [script to build a static binary for the rmb](https://github.com/threefoldtech/rmb/blob/master/build/alpine-static.sh) with the name `msgbusd`

- run RMB using

        ./msgbusd --twin <TWIN_ID>

## Create deployment

The deployment will include a kubernetes cluster consisting of a master and a worker machine on 2 VMs on the same node.

To have the successful deployment it should include the following:

- 1 network deployment (znetwork)
- 2 disk (zmount)
- 2 virtual machines (zmachine) where one is considered the master node and the other is the worker node
- 1 public IP attached to the kubernetes master node

### To deploy

### 1. Run test script with twinId to deploy 2

The test script can be found and used by following the steps in the README of [grid3_client_ts repo](readme)

### 2. Connect to the deployment over the public network

Edit `get_deployment.ts` script with the contract ID and Run it to get the deployment result.

```bash
cd ../scripts
tsc get_deployment.ts && node get_deployment.js 
```

And get the public IP from the public IP workload result.

```json
        ...
        {
            "version": 0,
            "name": "zpub",
            "type": "ipv4",
            "data": {},
            "metadata": "zpub ip",
            "description": "my zpub ip",
            "result": {
                "created": 1629128139,
                "state": "ok",
                "message": "",
                "data": {
                    "ip": "185.206.122.33/24",
                    "gateway": "185.206.122.1"
                }
            }
        }
        ...
```

Then ssh to the master public IP.

```bash
ssh root@<public_ip>
```

### 3. Wireguard needed to connect to the deployment over the private network

    [Interface]
    Address = 100.64.240.2/32
    PrivateKey = yYKiE0BFVt3fYYsbzLpApj1xPsdK3Xmw6BCLHCvWdHM=
    [Peer]
    PublicKey = XrL1Kl3oP1JTonHqTjt3Ig1A2re6A4/Fi9nn44+TOgM=
    AllowedIPs = 10.240.0.0/16, 100.64.240.1/32
    PersistentKeepalive = 25
    Endpoint = 185.206.122.31:6835



## example creating a zmachine 

  ```typescript

    import { Znet, Peer } from "./zos/znet";
import { Zmount } from "./zos/zmount";
import { Zmachine, ZmachineNetwork, ZNetworkInterface, Mount } from "./zos/zmachine";
import { ComputeCapacity } from "./zos/computecapacity";
import { Workload, WorkloadTypes } from "./zos/workload";
import { Deployment, SignatureRequirement, SignatureRequest } from "./zos/deployment";
import { TFClient } from "./tf-grid/client"
import { MessageBusClient } from "./rmb-client/client"

async function main() {

    // Create zmount workload
    let zmount = new Zmount();
    zmount.size = 1024 * 1024 * 1024 * 10;

    let zmount_workload = new Workload()
    zmount_workload.version = 0
    zmount_workload.name = "zmountiaia"
    zmount_workload.type = WorkloadTypes.zmount
    zmount_workload.data = zmount
    zmount_workload.metadata = "zm"
    zmount_workload.description = "zm test"

    // Create znet workload
    let peer = new Peer();
    peer.subnet = "10.240.2.0/24";
    peer.wireguard_public_key = "cEzVprB7IdpLaWZqYOsCndGJ5MBgv1q1lTFG1B2Czkc=";
    peer.allowed_ips = ["10.240.2.0/24", "100.64.240.2/32"];


    let znet = new Znet();
    znet.subnet = "10.240.1.0/24";
    znet.ip_range = "10.240.0.0/16";
    znet.wireguard_private_key = "SDtQFBHzYTu/c7dt/X1VDZeGmXmE7TD6nQC5tp4wv38=";
    znet.wireguard_listen_port = 7821;
    znet.peers = [peer];


    let znet_workload = new Workload();
    znet_workload.version = 0;
    znet_workload.name = "testznetwork";
    znet_workload.type = WorkloadTypes.network;
    znet_workload.data = znet;
    znet_workload.metadata = "zn"
    znet_workload.description = "zn test"

    // create zmachine workload
    let mount = new Mount();
    mount.name = "zmountiaia";
    mount.mountpoint = "/mydisk";

    let znetwork_interface = new ZNetworkInterface();
    znetwork_interface.network = "testznetwork";
    znetwork_interface.ip = "10.240.1.5";

    let zmachine_network = new ZmachineNetwork();
    zmachine_network.planetary = true;
    zmachine_network.interfaces = [znetwork_interface]

    let compute_capacity = new ComputeCapacity();
    compute_capacity.cpu = 1;
    compute_capacity.memory = 1024 * 1024 * 1024 * 2;

    let zmachine = new Zmachine();
    zmachine.flist = "https://hub.grid.tf/tf-official-apps/base:latest.flist";
    zmachine.network = zmachine_network;
    zmachine.size = 1;
    zmachine.mounts = [mount];
    zmachine.entrypoint = "/sbin/zinit init";
    zmachine.compute_capacity = compute_capacity;
    zmachine.env = { "SSH_KEY": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmm8OzLt+lTdGaMUwMFcw0P+vr+a/h/UsR//EzzeQsgNtC0bdls4MawVEhb3hNcycEQNd2P/+tXdLC4qcaJ6iABYip4xqqAeY098owGDYhUKYwmnMyo+NwSgpjZs8taOhMxh5XHRI+Ifr4l/GmzbqExS0KVD21PI+4sdiLspbcnVBlg9Eg9enM///zx6rSkulrca/+MnSYHboC5+y4XLYboArD/gpWy3zwIUyxX/1MjJwPeSnd5LFBIWvPGrm3cl+dAtADwTZRkt5Yuet8y5HI73Q5/NSlCdYXMtlsKBLpJu3Ar8nz1QfSQL7dB8pa7/sf/s8wO17rXqWQgZG6JzvZ root@ahmed-Inspiron-3576" };

    let zmachine_workload = new Workload();
    zmachine_workload.version = 0;
    zmachine_workload.name = "testzmachine";
    zmachine_workload.type = WorkloadTypes.zmachine;
    zmachine_workload.data = zmachine;
    zmachine_workload.metadata = "zmachine";
    zmachine_workload.description = "zmachine test"


    // Create deployment
    const twin_id = 10;
    let signature_request = new SignatureRequest();
    signature_request.twin_id = twin_id;
    signature_request.weight = 1;

    let signature_requirement = new SignatureRequirement();
    signature_requirement.weight_required = 1;
    signature_requirement.requests = [signature_request];

    let deployment = new Deployment()
    deployment.version = 0;
    deployment.twin_id = twin_id;
    deployment.expiration = 1626394539;
    deployment.metadata = "zm dep";
    deployment.description = "zm test"
    deployment.workloads = [zmount_workload, znet_workload, zmachine_workload];
    deployment.signature_requirement = signature_requirement;

    const mnemonic = "false boss tape wish talent pool ghost token exhibit response hedgehog invite";
    const url = "wss://explorer.devnet.grid.tf/ws"
    console.log(deployment.challenge_hash())
    console.log(deployment.challenge())
    deployment.sign(twin_id, mnemonic)
    let node_id = 2;
    let node_twin_id = 3;
    const contract_id = 49;

    const tf_client = new TFClient(url, mnemonic);
    await tf_client.connect();

    async function deploy() {
        function callback(data) {
            console.log(data)
            deployment.contract_id = data["contract_id"];
            let payload = JSON.stringify(deployment);
            console.log("payload>>>>>>>>>>>>>>>>>>", payload)

            let rmb = new MessageBusClient(6379);
            let msg = rmb.prepare("zos.deployment.deploy", [node_twin_id], 0, 2);
            rmb.send(msg, payload)
            rmb.read(msg, function (result) {
                console.log("result received")
                console.log(result)
            })
        }

        await tf_client.contracts.createContract(node_id, deployment.challenge_hash(), "", 0, callback);
    }

    async function update() {
        await tf_client.contracts.updateContract(contract_id, "", deployment.challenge_hash())
        deployment.contract_id = contract_id;
        let payload = JSON.stringify(deployment);
        console.log("payload>>>>>>>>>>>>>>>>>>", payload)

        let rmb = new MessageBusClient(6379);
        let msg = rmb.prepare("zos.deployment.update", [node_twin_id], 0, 2);
        rmb.send(msg, payload)
        rmb.read(msg, function (result) {
            console.log("result received")
            console.log(result)
        })
    }
    await deploy();
    // await update();
}

main()

```


## Example creating kubernetes

```typescript

import { Znet, Peer } from "./zos/znet";
import { Zmount } from "./zos/zmount";
import { Zmachine, ZmachineNetwork, ZNetworkInterface, Mount } from "./zos/zmachine";
import { ComputeCapacity } from "./zos/computecapacity";
import { Workload, WorkloadTypes } from "./zos/workload";
import { Deployment, SignatureRequirement, SignatureRequest } from "./zos/deployment";
import { TFClient } from "./tf-grid/client"
import { MessageBusClient } from "./rmb-client/client"

async function main() {

    // Create zmount workload
    let zmount = new Zmount();
    zmount.size = 1024 * 1024 * 1024 * 10;

    let zmount_workload = new Workload()
    zmount_workload.version = 0
    zmount_workload.name = "zmountiaia"
    zmount_workload.type = WorkloadTypes.zmount
    zmount_workload.data = zmount
    zmount_workload.metadata = "zm"
    zmount_workload.description = "zm test"

    // Create zmount workload
    let zmount1 = new Zmount();
    zmount1.size = 1024 * 1024 * 1024 * 10;

    let zmount_workload1 = new Workload()
    zmount_workload1.version = 0
    zmount_workload1.name = "zmountiaia1"
    zmount_workload1.type = WorkloadTypes.zmount
    zmount_workload1.data = zmount
    zmount_workload1.metadata = "zm1"
    zmount_workload1.description = "zm test1"

    // Create znet workload
    let peer = new Peer();
    peer.subnet = "10.240.2.0/24";
    peer.wireguard_public_key = "cEzVprB7IdpLaWZqYOsCndGJ5MBgv1q1lTFG1B2Czkc=";
    peer.allowed_ips = ["10.240.2.0/24", "100.64.240.2/32"];


    let znet = new Znet();
    znet.subnet = "10.240.1.0/24";
    znet.ip_range = "10.240.0.0/16";
    znet.wireguard_private_key = "SDtQFBHzYTu/c7dt/X1VDZeGmXmE7TD6nQC5tp4wv38=";
    znet.wireguard_listen_port = 6835;
    znet.peers = [peer];


    let znet_workload = new Workload();
    znet_workload.version = 0;
    znet_workload.name = "testznetwork1";
    znet_workload.type = WorkloadTypes.network;
    znet_workload.data = znet;
    znet_workload.metadata = "zn"
    znet_workload.description = "zn test"

    // create zmachine workload
    let mount = new Mount();
    mount.name = "zmountiaia";
    mount.mountpoint = "/mydisk";

    let znetwork_interface = new ZNetworkInterface();
    znetwork_interface.network = "testznetwork1";
    znetwork_interface.ip = "10.240.1.5";

    let zmachine_network = new ZmachineNetwork();
    zmachine_network.planetary = true;
    zmachine_network.interfaces = [znetwork_interface]

    let compute_capacity = new ComputeCapacity();
    compute_capacity.cpu = 1;
    compute_capacity.memory = 1024 * 1024 * 1024 * 2;

    let zmachine = new Zmachine();
    zmachine.flist = "https://hub.grid.tf/ahmed_hanafy_1/ahmedhanafy725-k3s-latest.flist";
    zmachine.network = zmachine_network;
    zmachine.size = 1;
    zmachine.mounts = [mount];
    zmachine.entrypoint = "/sbin/zinit init";
    zmachine.compute_capacity = compute_capacity;
    zmachine.env = {
        "SSH_KEY": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmm8OzLt+lTdGaMUwMFcw0P+vr+a/h/UsR//EzzeQsgNtC0bdls4MawVEhb3hNcycEQNd2P/+tXdLC4qcaJ6iABYip4xqqAeY098owGDYhUKYwmnMyo+NwSgpjZs8taOhMxh5XHRI+Ifr4l/GmzbqExS0KVD21PI+4sdiLspbcnVBlg9Eg9enM///zx6rSkulrca/+MnSYHboC5+y4XLYboArD/gpWy3zwIUyxX/1MjJwPeSnd5LFBIWvPGrm3cl+dAtADwTZRkt5Yuet8y5HI73Q5/NSlCdYXMtlsKBLpJu3Ar8nz1QfSQL7dB8pa7/sf/s8wO17rXqWQgZG6JzvZ root@ahmed-Inspiron-3576",
        "K3S_TOKEN": "hamadaellol",
        "K3S_DATA_DIR": "/mydisk",
        "K3S_FLANNEL_IFACE": "eth0",
        "K3S_NODE_NAME": "hamada",
        "K3S_URL": ""
    };

    let zmachine_workload = new Workload();
    zmachine_workload.version = 0;
    zmachine_workload.name = "testzmachine";
    zmachine_workload.type = WorkloadTypes.zmachine;
    zmachine_workload.data = zmachine;
    zmachine_workload.metadata = "zmachine";
    zmachine_workload.description = "zmachine test"


    // create zmachine workload
    let mount1 = new Mount();
    mount1.name = "zmountiaia1";
    mount1.mountpoint = "/mydisk";

    let znetwork_interface1 = new ZNetworkInterface();
    znetwork_interface1.network = "testznetwork1";
    znetwork_interface1.ip = "10.240.1.6";

    let zmachine_network1 = new ZmachineNetwork();
    zmachine_network1.planetary = true;
    zmachine_network1.interfaces = [znetwork_interface1]

    let compute_capacity1 = new ComputeCapacity();
    compute_capacity1.cpu = 1;
    compute_capacity1.memory = 1024 * 1024 * 1024 * 2;

    let zmachine1 = new Zmachine();
    zmachine1.flist = "https://hub.grid.tf/ahmed_hanafy_1/ahmedhanafy725-k3s-latest.flist";
    zmachine1.network = zmachine_network1;
    zmachine1.size = 1;
    zmachine1.mounts = [mount1];
    zmachine1.entrypoint = "/sbin/zinit init";
    zmachine1.compute_capacity = compute_capacity1;
    zmachine1.env = {
        "SSH_KEY": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmm8OzLt+lTdGaMUwMFcw0P+vr+a/h/UsR//EzzeQsgNtC0bdls4MawVEhb3hNcycEQNd2P/+tXdLC4qcaJ6iABYip4xqqAeY098owGDYhUKYwmnMyo+NwSgpjZs8taOhMxh5XHRI+Ifr4l/GmzbqExS0KVD21PI+4sdiLspbcnVBlg9Eg9enM///zx6rSkulrca/+MnSYHboC5+y4XLYboArD/gpWy3zwIUyxX/1MjJwPeSnd5LFBIWvPGrm3cl+dAtADwTZRkt5Yuet8y5HI73Q5/NSlCdYXMtlsKBLpJu3Ar8nz1QfSQL7dB8pa7/sf/s8wO17rXqWQgZG6JzvZ root@ahmed-Inspiron-3576",
        "K3S_TOKEN": "hamadaellol",
        "K3S_DATA_DIR": "/mydisk",
        "K3S_FLANNEL_IFACE": "eth0",
        "K3S_NODE_NAME": "worker",
        "K3S_URL": "https://10.240.1.5:6443"
    };

    let zmachine_workload1 = new Workload();
    zmachine_workload1.version = 0;
    zmachine_workload1.name = "testzmachine1";
    zmachine_workload1.type = WorkloadTypes.zmachine;
    zmachine_workload1.data = zmachine1;
    zmachine_workload1.metadata = "zmachine1";
    zmachine_workload1.description = "zmachine test1"

    // Create deployment
    const twin_id = 10
    let signature_request = new SignatureRequest();
    signature_request.twin_id = twin_id;
    signature_request.weight = 1;

    let signature_requirement = new SignatureRequirement();
    signature_requirement.weight_required = 1;
    signature_requirement.requests = [signature_request];

    let deployment = new Deployment()
    deployment.version = 0;
    deployment.twin_id = twin_id;
    deployment.expiration = 1626394539;
    deployment.metadata = "zm dep";
    deployment.description = "zm test"
    deployment.workloads = [zmount_workload, zmount_workload1, znet_workload, zmachine_workload, zmachine_workload1];
    deployment.signature_requirement = signature_requirement;

    console.log(deployment.challenge_hash())
    console.log(deployment.challenge())
    const mnemonic = "false boss tape wish talent pool ghost token exhibit response hedgehog invite";
    const url = "wss://explorer.devnet.grid.tf/ws"
    deployment.sign(twin_id, mnemonic)

    let node_id = 2;
    let node_twin_id = 3;
    const contract_id = 18;

    const tf_client = new TFClient(url, mnemonic);
    await tf_client.connect();

    async function deploy() {
        function callback(data) {
            console.log(data)
            deployment.contract_id = data["contract_id"];
            let payload = JSON.stringify(deployment);
            console.log("payload>>>>>>>>>>>>>>>>>>", payload)

            let rmb = new MessageBusClient(6379);
            let msg = rmb.prepare("zos.deployment.deploy", [node_twin_id], 0, 2);
            rmb.send(msg, payload)
            rmb.read(msg, function (result) {
                console.log("result received")
                console.log(result)
            })
        }

        await tf_client.contracts.createContract(node_id, deployment.challenge_hash(), "", 0, callback);
    }

    async function update() {
        await tf_client.contracts.updateContract(contract_id, "", deployment.challenge_hash())
        deployment.contract_id = contract_id;
        let payload = JSON.stringify(deployment);
        console.log("payload>>>>>>>>>>>>>>>>>>", payload)

        let rmb = new MessageBusClient(6379);
        let msg = rmb.prepare("zos.deployment.update", [node_twin_id], 0, 2);
        rmb.send(msg, payload)
        rmb.read(msg, function (result) {
            console.log("result received")
            console.log(result)
        })
    }
    await deploy();
    // await update();
}

main()

```