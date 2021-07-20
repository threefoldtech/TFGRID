# TFGrid DB Substrate remarks

This pallet does not support the use of any keys other than ed25519 to sign extrinsics. This is because we are using ed25519 keypairs on Zero-OS and we want to make this consistent on chain as well.

Every `address` field noted below in this document describes an ed25119 Public Key in [SS58](https://substrate.dev/docs/en/knowledgebase/advanced/ss58-address-format) format. We use this encoding since it's the Substrate standard.

All the objects depicted in this document are linked to an ed25519 Keypair. Once an object is created with a keypair, only the owner of the Keypair can make changes or delete that object. This way we can be sure that a user cannot change details for an object that does not belong to him.

An exception is made for Nodes; we allow Farmers to change the settings of their Node, since they own the physical hardware and must also be able to change it's digital representation.


> TODO: put extrinsics in blockchain defs (DYLAN)
> TODO: put ed25119 in blockchain defs (DYLAN)
> TODO: SS58 as def (DYLAN)


