[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/signTransaction

Decodes the input raw eth transaction bytes into an object, signs it using the input 'from' address and returns the resulting signed raw eth transaction bytes.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| from  | String  | yes          |  Address to use for signing (privatekey must be present in local wallet)  |
| transactionBytes  | String  | yes          |  HexString represantation of the bytes to decode  |



**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/sendTransaction' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"from": "....", "transactionBytes": "0x.........022"}'


**Example response**

{
    "transactionBytes": "xxxxxxxxxxxxxxxxx"
}