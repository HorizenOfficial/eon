[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/createSmartContract

Creates and send a transaction that deploys a smart contract.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| nonce  | integer  | no          | Optional field, if not specified the expected nonce from the state is used  |
| contractCode  | string  | yes         | HexString represantation of the compiled contract bytes  |

Parameters of the gasInfo object (optional):

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| gasLimit  | biginteger  | yes         | GAS limit |
| maxPriorityFeePerGas  | biginteger  | yes         | Max priority fee|
| maxFeePerGas  | biginteger  | yes         | Max fee per gas |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/createSmartContract' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"contractCode": "0x.........022", gasInfo: {.....}}'


**Example response**

    {
        "transactionId": "xxxxxxxxxxxxxxxxx"
    }