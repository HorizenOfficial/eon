[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/removeKeysOwnership

Create and send a transaction to remove a previously created association between  Horizen mainchain address and  EON sidechain addres.\
This function is used for voting pourposes in ZENDAO.

**Parameters**

| Name     | Type    | Required  | Description    |
| -------- | ------- | -------   | -------        | 
| ownershipInfo  | object  | yes         | Info about keys ownership (see below) |
| nonce  | integer  | no         | Nonce associated to the address that is sending the tx. If omitted the next valid nonce will be calculated automatically.  |
| gasInfo  | object  | no         | Info about GAS |

Parameters of the ownershipInfo object:

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| scAddress  | String  | yes         | Sidechain address associated. The corresponding private key must be present in the local wallet |
| mcTransparentAddress  | String  | yes         | Mainchain address|


Parameters of the gasInfo object:

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| gasLimit  | biginteger  | yes         | GAS limit |
| maxPriorityFeePerGas  | biginteger  | yes         | Max priority fee|
| maxFeePerGas  | biginteger  | yes         | Max fee per gas |


**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/removeKeysOwnership' -H 'Content-Type: application/json' -H 'accept: application/json' -d <requestBody>

The request body format is like this:

    {
        "ownershipInfo": {
            "scAddress": "......",
            "mcTransparentAddress": "...."
        }
        "nonce": nonce
    }

**Example response**

    {
        "transactionId": "xxxxxxxxxxxxxxxxx"
    }