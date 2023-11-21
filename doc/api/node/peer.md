[&lt; EON API Documentation](/doc/api/index.md) 
### node/peer

Returns info about a specific node peer.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| address  | string  | yes         | Peer to look at (format: ip:port)  |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/peer' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"address":"92.92.92.92:27017"}'  

**Example response**

    {
        "result" : {
            "peer" :  
                {
                    "remoteAddress" : "/143.42.26.149:5674",
                    "lastHandshake" : 0,
                    "lastMessage" : 0,
                    "name" : "unknown-/143.42.26.149:5674",
                    "agentName" : "unknown",
                    "protocolVersion" : "Version(0,0,1)"
                }
            }
    }





