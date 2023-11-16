[&lt; EON API Documentation](/doc/api/index.md) 
### node/blacklistedPeers

Return the list of the blacklisted peers.

**Parameters**

No parameters.

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/blacklistedPeers' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "addresses": [
                "92.92.92.92:27017",
                "81.15.92.92:8080
            ]
        }
     }





