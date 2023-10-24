[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/getAllBalances

Return all ZEN balances associated to Secp256k1 (EVM compliant) addresses contained in the node walle, returning a list of pairs (address, balance).

**Parameters**

No parameters.

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/getAllBalances' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "balances" : [ {
            "address" : "00c8f107a09cd4f463afc2f1e6e5bf6022ad4600",
            "balance" : 2330
            } ]
        }
    }