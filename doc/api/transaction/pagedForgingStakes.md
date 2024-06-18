[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/pagedForgingStakes

Returns the paginated list of forging stakes.<br>
Available from: EON 1.3.0

> [!IMPORTANT]
> This endpoint is deprecated and disabled from EON 1.4.0.

**Parameters**

| Name     | Type    | Required  | Description    |
| -------- | ------- | -------   | -------        | 
| startPos | integer | no (default 0) | Start position in the paginated list  |
| size     | integer | no (default 10)| Number of records to return |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/pagedForgingStakes' -H 'Content-Type: application/json' -H 'accept: application/json'  -d <requestBody>

The request body format is like this:

    {
        "startPos": 0,
        "size": 2
    }


**Example response**

    {
      "result" : {
        "nextPos": 2,
        "stakes" : [ {
            "stakeId" : "74b685e3b35941394a88085e864810ced41f978b008c60c4b9bc6364ff80c3a3",
            "forgerStakeData" : {
                "forgerPublicKeys" : {
                    "blockSignPublicKey" : {
                        "publicKey" : "041e38dc04de208df1c05eeee8a91b92e4336e11f5113b6505dd745df417b4ae"
                    },
                    "vrfPublicKey" : {
                        "publicKey" : "a6b64b0b6eff71b6514d9893d730664ef2297302db4f86e32280f270b5e4370a00"
                    }
                }
            },
            "ownerPublicKey" : {
                "address" : "edeb4bf692a4a1bfecad78e09be5c946ecf6c6da"
            },
            "stakedAmount" : 1000000000000000
        }, {
            "stakeId" : "665ea03b9f9c5e4060f28c50816289e69799548f6771de339ca4f318a845e9e0",
            "forgerStakeData" : {
                "forgerPublicKeys" : {
                    "blockSignPublicKey" : {
                        "publicKey" : "041e38dc04de208df1c05eeee8a91b92e4336e11f5113b6505dd745df417b4ae"
                    },
                    "vrfPublicKey" : {
                        "publicKey" : "a6b64b0b6eff71b6514d9893d730664ef2297302db4f86e32280f270b5e4370a00"
                    }
                }
            },
            "ownerPublicKey" : {
                "address" : "0676335330fa1e80427069a1de4612d9b79fcbe2"
            },
            "stakedAmount" : 1000000000000000000
        } ]
      }
    }