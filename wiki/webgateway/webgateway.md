# WebGateway

- choose a suitable web proxy solution
- create primitive datastructure to send to web proxy over RMB
- register as part of smart contract concept on Substrate
- bill bandwidth used a  proxy level

## requirements for web proxy part

- few binaries, as contained as possible
    - install script to deploy on any ubuntu above 20.04
- only param needed = farmid + mnemonic of account which owns farm

## billing remarks

- farmer receives for traffic going to/from webgateway see https://circles.threefold.me/project/despiegk-req_tfgrid_3_0/issue/17
- the user gets billed in line with https://info.threefold.io/#/threefold__grid_pricing (per GB)

## primitive workload def

> TODO: define & link to the spec

## TODO:

- [ ] choose proxy
- [ ] spec how to implement on blockchain
- [ ] spec how to gather billing info 
- [ ] spec how to gather info to reward farmer
- [ ] spec how to do provisioning

