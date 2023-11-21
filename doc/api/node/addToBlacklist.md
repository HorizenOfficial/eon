[&lt; EON API Documentation](/doc/api/index.md) 
### node/addToBlacklist

Force the node to add a specific peer to the blacklisted ones.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| address            | string  | yes         | Peer to blacklist (format: ip:port)  |
| durationInMinutes  | int     | yes         | Duration for the ban (in minutes). Must be > 0  |


**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/addToBlacklist' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"address":"92.92.92.92:27017", durationInMinutes: 20}'  

**Example response**

    {
        "result" : {}
     }





