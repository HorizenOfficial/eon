[&lt; EON API Documentation](/doc/api/index.md) 
### node/connectedPeers

Returns the list of node peers currently connected to this node

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/connectedPeers' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "peers" : [ 
                {
                    "remoteAddress" : "/139.162.18.215:5674",
                    "localAddress" : "/10.0.2.15:39164",
                    "lastHandshake" : 1698066516794,
                    "lastMessage" : 1698069128120,
                    "name" : "evmapp-testnet_forger11",
                    "agentName" : "2-Hop",
                    "protocolVersion" : "Version(0,0,1)",
                    "connectionType" : "Outgoing"
                    }, {
                    "remoteAddress" : "/172.105.185.87:5674",
                    "localAddress" : "/10.0.2.15:43622",
                    "lastHandshake" : 1698066486764,
                    "lastMessage" : 1698069135249,
                    "name" : "evmapp-testnet_forger7",
                    "agentName" : "2-Hop",
                    "protocolVersion" : "Version(0,0,1)",
                    "connectionType" : "Outgoing"
                }
            ]
            }
        }





