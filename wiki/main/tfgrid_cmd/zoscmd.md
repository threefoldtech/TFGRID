# TFGrid CMD

> OUTDATED

- tfgrid_cmd = command line which can process dir with workload defs inside
- each workload def is a json or yaml file which describes one of the X primitives
- all primitives in [tfgrid_primitives](internet4:tfgrid_primitives) need to be supported
- tfgrid_cmd will talk to TFGRIDDB and RMB to bring primitives alive
- do logging in a text file in the dir
- the workload defs can be modified to have the feedback inside
- signing & coordination with multiple 3Nodes and TFGridDB happens by tfgrid_cmd
- the private key for the user is given to tfgrid_cmd or in predefined directory e.g. ~/.tfgrid_cmd/...


## todo's

- [ ] good definition of each primitive workload def
    - [ ] schema def in vlang (its a good spec format)
    - [ ] each primitive is a directory with necessary explanation, ...
- [ ] examples in json & yaml (some pre-made directories)
- [ ] explain how feedback is given
- [ ] make sure tfgridDB is also documented

## will be used from VLANG

- make supporting functions in vlang to go from schema and dump to json in format as needed for tfgrid_cmd
- vlang is using the functions over RMB

!!!def alias:tfgrid_cmd

>TODO: PHASE2