[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/spendForgingStake

Creates and signs a transaction to remove a forger stake and have ZEN back in the wallet.\
Note: is not possible to remove partially a forging stake, all the stacked ZEN associated to the specific stakeId will be removed in a single transaction.

> [!IMPORTANT]
> This endpoint is deprecated and disabled from EON 1.4.0.
> Same action will be possible through the native smart contract method withdraw on [ForgerStakesV2](/doc/nativesc/contracts/ForgerStakesV2.md)

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| stakeId  | string  | yes         | Id of the stake to be removed  |
| nonce    | string  | no         | Nonce associated to the address that is sending the tx. If omitted the next valid nonce will be calculated automatically.  |
| gasInfo  | object  | no         |   |

Parameters of the gasInfo object:

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| gasLimit  | biginteger  | yes         | GAS limit |
| maxPriorityFeePerGas  | biginteger  | yes         | Max priority fee|
| maxFeePerGas  | biginteger  | yes         | Max fee per gas |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/spendForgingStake' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"stakeId": "xxxxx"}'


**Example response**

    {
        "transactionId": "xxxxxxxxxxxxxxxxx"
    }