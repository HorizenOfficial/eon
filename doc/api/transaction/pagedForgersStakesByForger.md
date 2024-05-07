[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/pagedForgerStakesByForger

Returns the paginated list of forging stakes, filtered by a specific forger.<br>
Available from: EON 1.4.0

**Parameters**

| Name     | Type    | Required  | Description    |
| -------- | ------- | -------   | -------        | 
| blockSignPubKey   | string | yes | blockSignPubKey identifying the forger  |
| vrfPubKey   | string | yes | vrfPubKey identifying the forger  |
| startPos | integer | no (default 0) | Start position in the paginated list  |
| size     | integer | no (dafault 10)| Number of records to return |
| nonce    | integer | no        | Nonce associated to the address that is sending the tx. If omitted the next valid nonce will be calculated automatically.  |
| gasInfo  | object  | no        | Info about GAS |

Parameters of the gasInfo object:

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| gasLimit  | biginteger  | yes         | GAS limit |
| maxPriorityFeePerGas  | biginteger  | yes         | Max priority fee|
| maxFeePerGas  | biginteger  | yes         | Max fee per gas |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/pagedForgerStakesByForger' -H 'Content-Type: application/json' -H 'accept: application/json'  -d <requestBody>

The request body format is like this:

    {
        "blockSignPubKey": "10e9b5236a56cddb9f0332e9dd6d69151494f24172b26ab24a27473bbc92a181",
        "vrfPubKey": "6a376f8a88b386f69296baa0792641d393c85a19b28dfd4a11d8f0a74618873280",
        "startPos": 0,
        "size": 10
    }


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
          "address" : "775138d910274ff291162b1bc6fd237bd7aea5cc"
        },
        "stakedAmount" : 99000000000000000000
      }
    }]
  }
}