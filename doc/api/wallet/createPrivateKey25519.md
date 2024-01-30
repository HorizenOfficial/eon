[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/createPrivateKey25519

Create a private key in the 25519 format.
25519 keys are used in EON for designating forgers.
Returns the correspondent public key.

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/createPrivateKey25519' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "proposition" : {
            "publicKey" : "4b50edf43fddcf29afceacfcc9c5c16edb16de6550b9172c7190bfe9fdad0f45"
            }
        }
    }

