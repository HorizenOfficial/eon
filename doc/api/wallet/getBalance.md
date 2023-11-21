[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/getBalance

Return the ZEN balance associated to a specific Secp256k1 (EVM compliant) address contained in the node wallet.

**Parameters**

No parameters.

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/getBalance' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"address":"00c8f107a09cd4f463afc2f1e6e5bf6022ad4600"}'  

**Example response**

    {
        "result" : {
            "balance" : 3330
        }
    }