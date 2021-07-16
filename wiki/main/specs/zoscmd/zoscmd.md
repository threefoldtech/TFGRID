# ZOSCMD

- zoscmd = command line which can process dir with workload defs inside (rust)
- each workload def is a json or yaml file which describes one of the X primitives
- all primitives in [tfgrid_primitives](internet4:tfgrid_primitives) need to be supported
- zoscmd will talk to TFGRIDDB and RMB to bring primitives alive
- do logging in a text file in the dir
- the workload defs can be modified to have the feedback inside
- signing & coordination with multiple 3Nodes and TFGridDB happens by zoscmd
- the private key for the user is given to zoscmd or in predefined directory e.g. ~/.zoscmd/...


## TODO

- [ ] good definition of each primitive workload def
    - [ ] schema def in vlang (its a good spec format)
    - [ ] each primitive is a directory with necessary explanation, ...
- [ ] examples in json & yaml (some pre-made directories)
- [ ] explain how feedback is given
- [ ] make sure tfgridDB is also documented


## Link to VLANG

- make supporting functions in vlang to go from schema and dump to json in format as needed for zoscmd
- in other words the vlang is for now not using RMB directly but putting files in dir and calling the zoscmd

## RMDB

- if needed re-implement in rust

