[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/createPrivateKeySecp256k1

Create a private key in the Secp256k1 format.\
Secp256k1 keys are the standard used in Ethereum EVMs and also by EON.\
Returns the correspondent public address.

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/createPrivateKeySecp256k1' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "address" : "00c8f107a09cd4f463afc2f1e6e5bf6022ad4600"
        }
    }