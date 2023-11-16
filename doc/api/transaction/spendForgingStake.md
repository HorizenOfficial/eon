[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/spendForgingStake

Creates and signs a transaction to remove a forger stake and have ZEN back in the wallet.
Note: is not possible to remove partially a forging stake, all the stacked ZEN will be removed in a single transaction.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| stakeId  | string  | yes         | Id of the stake to be removed  |
| nonce    | string  | no         |   |
| gasInfo  | object  | no         |   |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/spendForgingStake' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"stakeId": "xxxxx"}'


**Example response**

    {
        "transactionId": "xxxxxxxxxxxxxxxxx"
    }