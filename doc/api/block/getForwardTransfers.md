[&lt; EON API Documentation](/doc/api/index.md) 
### block/getForwardTransfers

Returns info on the forward transfer included a specific block (if any).\n
A forward transfer is a transfer of ZEN originated from the mainchain.


**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| blockId  | String  | yes         | Block ID       |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/block/getForwardTransfers' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"blockId":"99e4a42fce9befd560cbbb515d9a692b7dd5d32a3491fa9325c43580c9f1b4fc"}'

**Example response**

    {
        "result" : {            
            "forwardTransfers" : [
                {
                "to" : "c49dedc85a2c360fea781bcea2bc5d58fde19",
                "value" : 2000000
                }
            ]
        }
    }



