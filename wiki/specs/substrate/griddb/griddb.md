# Threefold Grid Database

The puprose of the Grid Database on Substrate is to decentralise the way we work with identities.

Following identities are stored on Substrate:

- Entities (physical humain beings, only 1 entity per human).
- Twin (digital copies of a human, one can have many).
- Farmers (Threefold grid Farmers).
- Node (Threefold grid physical Nodes).

[Entity Relationship Diagram](https://github.com/threefoldtech/substrate-pallets/blob/master/pallet-tfgrid/diagram.md)

## Entities

Entities are links to physical human beings. Only one entity object per human can or must be created in the database. An person will register himself on substrate with the Threefold Connect application.

## Twins

Twins are digital copies of humain beings that control:

- Nodes
- Farms
- Digital twins (assitants)

A twin is an anonymous entity in substrate, if a twin wishes to make himself a known enitity he can link up with an Entity (see above).

## Farmers

Farmers are digital twins (twins) that control a physical Node's Farm. A farmer can have multiple nodes and can set it's prices by linking to a Pricing Policy. (TODO define pricing policies). A farmer can also provide public ips to his consumers.

## Nodes

Nodes are digital twins (twins) that control a physical Node. A node is always linked to a Farm (see above). A Node can accept workloads and bill the consumer's wallet accordingly.

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