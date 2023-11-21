[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/allPublicKeys

Returns the list of all keys contained in this node wallet.
For 25519 and VRF keys, the public key is returned, for Secp256k1 keys the EVM public address is returned.

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/allPublicKeys' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

{
  "result" : {
    "propositions" : [ {
      "publicKey" : "4b50edf43fddcf29afceacfcc9c5c16edb16de6550b9172c7190bfe9fdad0f45"
    }, {
      "address" : "00c8f107a09cd4f463afc2f1e6e5bf6022ad4600"
    }, {
      "publicKey" : "593b72416bce63251ce9f5c213127b861dd2aa34c03b6dffd72510678958dc2f80"
    } ]
  }
}