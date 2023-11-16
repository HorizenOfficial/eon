[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/importSecret

Import a specific private key in the local wallet.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| privKey  | string  | yes         | Private key to be imported  |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/importSecret' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"privKey":"xxxxx"}'  

**Example response**

    {
        "result" : {
            "proposition" : {
            "address" : "00c8f107a09cd4f463afc2f1e6e5bf6022ad4600"
            }
        }
    }