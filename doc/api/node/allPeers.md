[&lt; EON API Documentation](/doc/api/index.md) 
### node/allPeers

Returns the list of all sidechain node peers

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/allPeers' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "peers" : [ 
                {
                    "remoteAddress" : "/143.42.26.149:5674",
                    "lastHandshake" : 0,
                    "lastMessage" : 0,
                    "name" : "unknown-/143.42.26.149:5674",
                    "agentName" : "unknown",
                    "protocolVersion" : "Version(0,0,1)"
                }, 
                {
                    "remoteAddress" : "/192.46.215.198:5674",
                    "lastHandshake" : 0,
                    "lastMessage" : 0,
                    "name" : "unknown-/192.46.215.198:5674",
                    "agentName" : "unknown",
                    "protocolVersion" : "Version(0,0,1)"
                }
            ]
            }
        }





