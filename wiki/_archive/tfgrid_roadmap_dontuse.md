## TFGrid 3.0 Roadmap

This document only describes how to use the low level primitives on the TFGrid.

The higher level services like Kubernetes, [3Bot](3bot) and [Quantum Safe Filesystem](quantumsafestorage:qsfs) are layers using these primitives.


# TFGrid 3.0 Summer 2021

|          |                                | docu                |
| -------- | ------------------------------ | ------------------- |
| zmachine | VM = hypervisor based          | [doc](api_zmachine) |
| zmount   | SSD storage space for ZMachine | [doc](api_zmount)   |
| zdb      | low level storage db           | [doc](api_zdb)      |
| zkube    | kubernetes deployment          | [doc](api_zkube)    |

### Internals

|                      |                                                | docu                                     |
| -------------------- | ---------------------------------------------- | ---------------------------------------- |
| zreservation         | reservation of 1 primitive                     | [doc](api_zreservation)                  |
| grid_agent           | agent which works on our behalf                | [doc](agent_specs)                       |
| tfgriddb             |                                                |                                          |
| tfchain              |                                                |                                          |
| ipaddress_mgmt       |                                                | [doc](ipaddress_mgmt)                    |
| kubernetes net       | ipv6 and default planetary network integration |                                          |
| planetary network    | can be linked to every primitive workload      |                                          |
| auto billing/pricing | per hour billing of all primitives             | [doc](threefold:pricing)                 |
| discounts            | discounts in line with staking                 | [doc](threefold:staking_discount_levels) |

# TFGrid 3.1 Sept/Oct 2021

|                    |                                                    | docu            |
| ------------------ | -------------------------------------------------- | --------------- |
| corex              | process manager integrated                         |                 |
| zmachine multisign | allow multiple parties to multisign the deployment |                 |
| znet               | peer2peer network between zmachines                | [doc](api_znet) |

# TFGrid 3.2 Q4 2021

|                       |                                                    | docu                           |
| --------------------- | -------------------------------------------------- | ------------------------------ |
| corex                 | process manager integrated                         |                                |
| zdeployment multisign | allow multiple parties to multisign the deployment | [zdeployment](api_zdeployment) |


### Storage (uses SU)

- zos_fs : deduped imutable filesystem
- zmount : a part of a SSD (fast disk), mounted underneith your zmachine
- zstor_fs : unbreakable storage system (secondary storage only)
- zdb : the lowest level storage primitive, is a key value stor, used underneith other storage mechanisms typically
- zdisk : OEM only, virtual disk format

### Network (uses NU)

- znet : private network between zmachines
- planetary_network : peer2peer end2end encrypted global network
- znic : interface to planetary network
- webgw : interface between internet and znet
- p2pagent : p2p agent terminates the traffic coming from the webgw.


## Advantages

- zero_install
- unbreakable_storage
- zero_hacking_surface
- zero_boot
- deterministic_deployment
- zos_protect


!!!def alias:tfgrid_primitives,grid_primitives