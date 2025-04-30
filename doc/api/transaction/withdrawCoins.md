[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/withdrawCoins

Creates and posts a backward transfer transaction to send some ZEN back to the mainchain

> [!IMPORTANT]
> This endpoint is deprecated and disabled from EON 1.5.0.
> 
**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| nonce  | integer  | no         | Nonce associated to the address that is sending the tx. If omitted, the latest nonce saved in the state will be used by default.  |
| withdrawalRequest  | object  | yes         | Description of the  withdrawal request |
| gasInfo  | object  | no         | Info about GAS |


Parameters of the withdrawalRequest object:

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| mainchainAddress  | string  | yes         | Receiver of the backward tx  |
| value  | long  | yes         | ZEN value to be sent (in Zentoshi: 1 Zen = 100000000)|

Parameters of the gasInfo object:

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| gasLimit  | biginteger  | yes         | GAS limit |
| maxPriorityFeePerGas  | biginteger  | yes         | Max priority fee|
| maxFeePerGas  | biginteger  | yes         | Max fee per gas |


**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/withdrawCoins' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"withdrawalRequest": { "mainchainAddress": "ztYQpCcqUqd8LMFiM9p7Zp4hRSkjqrcWAsu", "value": 100000000}}' 

**Example response**

    {
        "result" : {
            "transactionId" : "c6a3288142b2e0800ccffb42a9bb925e5bcb3e613204f291883868a94b58039c"
        }
    }