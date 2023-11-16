[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/openForgerList

Execute a transaction  expressing the vote for opening the restricted forgers list.
This transaction is allowed only when the forgers are initially restricted, and can be executed only by one of the allowed forgers. Forger's keys of the voter must be present in the local wallet.
When the majority of the closed forgers have voted to open forging, everyone will be allowed to stake and partecipate in forging.

**Parameters**

| Name     | Type    | Required  | Description    |
| -------- | ------- | -------   | -------        | 
| forgerIndex  | integer  | yes         | Index (0-based) of the forger that is voting, referred to the allowed forgers list in the configuration file. Forger's keys of the voter must be present in the local wallet.  |
| nonce  | integer  | no         | Nonce associated to the address that is sending the tx. If omitted the next valid nonce will be calculated automatically.  |
| gasInfo  | object  | no         | Info about GAS |

Parameters of the gasInfo object:

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| gasLimit  | biginteger  | yes         | GAS limit |
| maxPriorityFeePerGas  | biginteger  | yes         | Max priority fee|
| maxFeePerGas  | biginteger  | yes         | Max fee per gas |


**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/openForgerList' -H 'Content-Type: application/json' -H 'accept: application/json' -d <requestBody>

The request body format is like this:

    {
        "forgerIndex": 2,
        "nonce": nonce
    }

**Example response**

{
    "transactionId": "xxxxxxxxxxxxxxxxx"
}