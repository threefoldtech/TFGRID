
## Link between different Money Blockchain & TFChain

TFChain is our blockchain based on Parity/Substrate.

We are building a consensus layer which allows us to easily bridge between different money blockchains.

Today one of the money blockchains we support is stellar blockchain, its our aim to support many more.

The TFT main chain will be on Parity/Substrate (our own money blockchain), but because of this mechanism compatible with more chains.

We want to bridge the TF main chain also with Polkadot/Kusama.


```mermaid


graph TB
    subgraph Money Blockchain
        money_blockchain --- account1a
        money_blockchain --- account2a
        money_blockchain --- account3a
        account1a --> money_user_1
        account2a --> money_user_2
        account3a --> money_user_3
        click money_blockchain "/info/threefold/#money_blockchain"
    end
    subgraph ThreeFold Blockchain On Parity
        TFBlockchain --- account1b[account 1]
        TFBlockchain --- account2b[account 2]
        TFBlockchain --- account3b[account 3]
        account1b --- smart_contract_data_1
        account2b --- smart_contract_data_2
        account3b --- smart_contract_data_3
        click TFBlockchain "/info/threefold/#tfchain"
    end
    account1b ---- account1a[account 1]
    account2b ---- account2a[account 2]
    account3b ---- account3a[account 3]

    consensus_engine --> smart_contract_data_1[fa:fa-ban smart contract metadata]
    consensus_engine --> smart_contract_data_2[fa:fa-ban smart contract metadata ]
    consensus_engine --> smart_contract_data_3[fa:fa-ban smart contract metadata]
    consensus_engine --> account1a
    consensus_engine --> account2a
    consensus_engine --> account3a
    click consensus_engine "/info/threefold/#consensus_engine"


```

Above diagram shows how our consensus engine can deal with Substrate and multiple Money Blockchains at same time.

This is a very novel approach which allows us many possibilities for the future.

!!!include:consensus3_toc