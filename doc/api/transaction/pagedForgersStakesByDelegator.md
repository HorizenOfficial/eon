[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/pagedForgerStakesByDelegator

Returns the paginated list of forging stakes, filtered by a specific delegator.<br>
Available from: EON 1.4.0

**Parameters**

| Name     | Type    | Required  | Description    |
| -------- | ------- | -------   | -------        | 
| delegatorAddress | address | yes | Address of the delegator  |
| startPos | integer | no (default 0) | Start position in the paginated list  |
| size     | integer | no (default 10)| Number of records to return |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/pagedForgerStakesByDelegator' -H 'Content-Type: application/json' -H 'accept: application/json'  -d <requestBody>

The request body format is like this:

    {
        "delegatorAddress": "62b1bc6fd237b775138d910274ff2911d7aea5cc",
        "startPos": 0,
        "size": 10
    }


**Example response**

    {
      "result" : {
        "nextPos": 10,
        "stakes" : [ {
            "forgerPublicKeys" : {
              "blockSignPublicKey" : {
                "publicKey" : "10e9b5236a56cddb9f0332e9dd6d69151494f24172b26ab24a27473bbc92a181"
              },
              "vrfPublicKey" : {
                "publicKey" : "6a376f8a88b386f69296baa0792641d393c85a19b28dfd4a11d8f0a74618873280"
              }
            },
            "stakedAmount" : 1000000000000000000
        }, {
            "forgerPublicKeys" : {
              "blockSignPublicKey" : {
                "publicKey" : "4172b26ab24a27473bbc910e9b5236a56cddb9f0332e9dd6d69151494f22a181"
              },
              "vrfPublicKey" : {
                "publicKey" : "aa0792641d393c85a19b28dfd4a6a376f8a88b386f69296b11d8f0a74618873280"
              }
            },
            "stakedAmount" : 99000000000000000000
        }]
      }
    }
