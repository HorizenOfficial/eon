[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/myForgingStakes

Returns the forging stakes belonging to keys contained in the node wallet.


**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/myForgingStakes' -H 'Content-Type: application/json' -H 'accept: application/json' 


**Example response**

{
  "result" : {
    "stakes" : [ {
      "forgerStakeData" : {
        "forgerPublicKeys" : {
          "blockSignPublicKey" : {
            "publicKey" : "10e9b5236a56cddb9f0332e9dd6d69151494f24172b26ab24a27473bbc92a181"
          },
          "vrfPublicKey" : {
            "publicKey" : "6a376f8a88b386f69296baa0792641d393c85a19b28dfd4a11d8f0a74618873280"
          }
        },
        "ownerPublicKey" : {
          "address" : "62b1bc6fd237b775138d910274ff2911d7aea5cc"
        },
        "stakedAmount" : 1000000000000000000
      }
    }, {
      "forgerStakeData" : {
        "forgerPublicKeys" : {
          "blockSignPublicKey" : {
            "publicKey" : "10e9b5236a56cddb9f0332e9dd6d69151494f24172b26ab24a27473bbc92a181"
          },
          "vrfPublicKey" : {
            "publicKey" : "6a376f8a88b386f69296baa0792641d393c85a19b28dfd4a11d8f0a74618873280"
          }
        },
        "ownerPublicKey" : {
          "address" : "5138d910274ff2962b1bc6fd237b7711d7aea5cc"
        },
        "stakedAmount" : 99000000000000000000
      }
    }]
  }
}