[&lt; EON API Documentation](/doc/api/index.md) 
### node/removeFromBlacklist

Force the node to remove a specific peer to the blacklisted ones.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| address  | string  | yes         | Peer to remove form blacklist (format: ip:port)  |



**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/removeFromBlacklist' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"address":"92.92.92.92:27017"}'  

**Example response**

    {
        "result" : {}
     }





