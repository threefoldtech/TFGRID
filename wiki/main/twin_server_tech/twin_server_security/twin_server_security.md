# Twin Server security

## State and security

Given the architecture where the twin server implements the clients to tfchain and Stellar, it is crucial to define if the twin server nodejs component that contains these clients has contains state or has access to the secret keys of the accounts on tfchain and on the Stellar network.

### The nodejs component contains the state

Seems like the easiest solution but has huge security impact, not just from an attack surface but also from a configurational perspective.

As an example, let's say there are 2 Stellar accounts, who and through which application can execute a transfer command and on which wallet?

### The nodejs component does not contain the state

Makes the nodejs component kind of a library without bloating it with access rights and security concerns.

As a downside this does mean that the secrets need to be passed over the RMB or credentials to fetch the secrets can be passed as well.

A keystore and a "who through which app can do what" can be implemented seperately and gradually.

The secret or credentials and the authorization can be passed to the nodejs component over the RMB.
The nodejs component now has access to the account and can do a small validation check if the command is allowed. 