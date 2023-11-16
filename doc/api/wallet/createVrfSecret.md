[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/createVrfSecret

Create a VrfSecret.\
VrfSecrets are used by forgers to partecipate at the forgers' lottery.\
Returns the correspondent public key.

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/createVrfSecret' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "proposition" : {
            "publicKey" : "593b72416bce63251ce9f5c213127b861dd2aa34c03b6dffd72510678958dc2f80"
            }
        }
    }