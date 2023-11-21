[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/decodeTransactionBytes

Returns a JSON representation of a transaction given its byte serialization.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| transactionBytes  | String  | yes          |  HexString represantation of the bytes to decode  |



**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/decodeTransactionBytes' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"transactionBytes": "0x.........022"}'


**Example response**

    {
        transaction: ......
    }