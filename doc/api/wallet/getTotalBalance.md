[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/getTotalBalance

Return the total ZEN balance of the wallet **considering only Secp256ki (EVM compliant) addresses** 

**Parameters**

No parameters.

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/getTotalBalance' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "balance" : 3330
        }
    }