
An grid_agent works on behalf of user and talks to the TFChain and to the different 3Nodes.

```mermaid
graph TD

    subgraph PCUSER[Computer from TFGrid user]
    agent[Grid Agent] --- webinterface[rest webinterface]
    agent --- cmdline[cmdline + json data]
    Terraform --> agent
    end    

    agent ---|HTTPS| explorer((TFCHAIN))
    agent ---|RMB| tnode[3Node]

    explorer((TFCHAIN))

```


grid_agent is the connection point for the developer.

Functions of the grid_agent

- blockchain client to TFChain
- wallet using TFChain TFT
- rest interface to allow developer to deploy tfgrid_primitives
- signing/encryption primitives as needed
- interface to RMB
- type checking for strongly typed structs as needed on TFGrid
- terraform plugin
  
> implemented as part of twin_server

```mermaid
graph TD

    subgraph PCUSER[Computer from TFGrid user]
    agent[Grid Agent]
    end    

    agent --- explorer((TFCHAIN))
    agent ---|peer2peer| tnode[[3Node]]
    agent ---|peer2peer| tnode2[[3Node]]
    agent ---|peer2peer| tnode3[[3Node]]

    tnode ---|peer2peer| tnode2
    tnode2 ---|peer2peer| tnode3

    tnode --- explorer
    tnode2 --- explorer
    tnode3 --- explorer

    subgraph TFCHAIN
    explorer((explorers))
    nodes[(BC nodes ...)]
    nodes2[(... BC nodes)]
    end        

  
```

All peer2peer traffic is using RMB.
