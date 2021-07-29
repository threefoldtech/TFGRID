- need to see types in https://github.com/threefoldtech/zos/tree/zos3/docs/pkg/gridtypes
- can check https://github.com/threefoldtech/vgrid/tree/development/zos for an example client
- to be able to send deployment requests and sign them you need to have an account / mnemonics / seed saved https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Fexplorer.devnet.grid.tf%2Fws#/explorer



## notes
- script to get deployment https://github.com/threefoldtech/vgrid/blob/development/getdeployment.v

- script to create deployment https://github.com/threefoldtech/vgrid/blob/- development/testdeployment.v (this one has wireguard, zmount, zmachine + ssh)
- deleting a deployment can be done by canceling the contract which will get it into state deleted in 5 mins
- you can update deployments by increasing the version of the inner workloads and increase the version on the deployment object as well
- deployment.contract_id is done by
   - getting deployment hash
   - creating contract on substrate with that hash to get a contract_id that you can set on the deployment object that you can sign and submit to the node.

- the workloads needs to be defined in a language that supports something like `json Raw Message` in golang.

