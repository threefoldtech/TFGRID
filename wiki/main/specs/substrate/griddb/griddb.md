# Threefold Grid Database

The puprose of the Grid Database on Substrate is to decentralise the way we work with identities.

Following identities are stored on Substrate:

- Entities (physical humain beings, only 1 entity per human).
- Twin (digital copies of a human, one can have many).
- Farmers (Threefold grid Farmers).
- Node (Threefold grid physical Nodes).

[Entity Relationship Diagram](./er_diagram.md)

## Entities

Entities are links to physical human beings. Only one entity object per human can or must be created in the database. A person will register himself on substrate through the Threefold Connect application.

## Twins

Twins are digital copies of humain beings that control:

- Nodes
- Farms
- Digital twins (assitants)

Twins must set an IP field, this field can either be ipv4/ipv6. Be setting this value, Twins can talk to eachother over a message bus (RMB).

A twin is an anonymous entity in substrate, if a twin wishes to make himself a known enitity he can link up with an Entity (see above).

## Farmers

Farmers are digital twins (Twin object) that control a physical Node's Farm. Before one can construct a Farm object, a Twin must be created. With this Twin's keypair a Farm should be created, this way a Twin and a Farm will be linked to eachother.

A farmer can have multiple nodes and can set it's prices by linking to a Pricing Policy. (TODO define pricing policies). A farmer can also provide a list of public ips so that consumers can rent an IP from that list.

## Nodes

Nodes are digital twins (Twin object) that control a physical Node. A node is always linked to a Farm (see above). Before a Node object can be registered, a Twin object must be created. With this Twin's keypair a Node should be registered, this way Twin and a Node will be linked to eachother.

On Node creation, a Farm ID must be specified. This Farm ID is passed as a kernel argument on the boot process. When a Farm ID is set, only that farm can manage this Node.

A Node can accept workloads and bill the consumer's wallet accordingly.

## Creating / updating / deleting objects

A user can create / update / delete objects on substrate by calling `Extrinsics` on the TfgridModule. Every extrinsic costs some amount of tokens.

Following extrinsics are exposed:

Entities:

- createEntity(..)
- updateEntity(..)
- deleteEntity(..)

Twins:

- create_twin(..)
- update_twin(..)
- delete_twin(..)

Entity-Twin Relation:

- addTwinEntity(..)
- removeTwinEntity(..)

Nodes:

- createNode(..)
- updateNode(..)
- deleteNode(..)

Farms:

- createFarm(..)
- updateFarm(..)
- deleteFarm(..)
- addFarmIp(..)
- removeFarmIp(..)

Every extrinsic must by signed by the user / digital twin that owns or will own the object.

A [cli-tool](https://github.com/threefoldtech/tfgrid-substrate/blob/master/cli-tool/readme.md) can be used to call the extrincis

Or you could use the polkadot UI apps to call extrinsics from the browser:

https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Fexplorer.devnet.grid.tf%2Fws#/extrinsics

## Graphql

We store every creation / update / deletion of above objects in a graphql database. An end user of any other application can query the objects from the substrate database without having to talk to the substrate nodes. 

[example](graphql)

## Note

Full type definition can be found [here](https://github.com/threefoldtech/vgrid/blob/main/tfgriddb/tfgriddb_model.v)