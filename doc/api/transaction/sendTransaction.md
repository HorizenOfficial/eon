[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/sendTransaction

Validates and sends a transaction, given its serialization as input. Then returns the id of the transaction.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| transactionBytes  | String  | yes          |  HexString represantation of the bytes to decode  |



**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/sendTransaction' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"transactionBytes": "0x.........022"}'


**Example response**

{
    "transactionId": "xxxxxxxxxxxxxxxxx"
}


