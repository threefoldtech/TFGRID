# Z_API

The API which describes how to deploy IT workloads in the TFGrid.

This is done by means of a zreservation.

This is used by endusers.

## Architecture

- twin server = the one talking to tfchain, Zero-OS nodes over RMB for deployment
- vlang scripts use primitives as defined here and talk to twin server over RMB

### Types for TFGrid 3.0

- [zmachine = the compute construct](api_zmachine)
- [zkube = the kubernetes construct](api_zkube)
- [zmount](api_zmount)
- [peer2peer network](api_znet)
- [low level storage DB: ZDB](api_zdb)

>TODO: KRISTOF NEEDS TO REDO TOGETHER WITH THABET

!!!def alias:z_api