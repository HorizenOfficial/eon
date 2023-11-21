[&lt; EON API Documentation](/doc/api/index.md) 
### node/disconnect

Force the node to disconnect from a specific peer

**Parameters**

| Name     | Type    | Required    | Description      |
| -------- | ------- | -------     | -------          | 
| host     | string  | yes         | Host to connect  |
| port     | int     | yes         | Port             |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/disconnect' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"host":"myhost.com", "port": 8090}'  

**Example response**

    {
        "result" : {
            "disconnectedFrom" : "143.42.26.149:5674"
        }
     }





