[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/exportSecret

Prints out the privatekey correspondent to a public key or EVM address contained in this wallet

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| publickey  | string  | yes         | Public key (or address for Secp256k1) to be exported  |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/exportSecret' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"publickey":"00c8f107a09cd4f463afc2f1e6e5bf6022ad4600"}'  

**Example response**

    {
        "result" : {
            "privKey" : "xxxxxxxxxxxxxx"
        }
    }