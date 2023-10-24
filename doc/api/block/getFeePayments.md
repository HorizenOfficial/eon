[&lt; EON API Documentation](/doc/api/index.md) 
### block/getFeePayments

Returns info on the fee redistributed to forgers, at the end of each withdrawal epoch.
**This endpoint returns a non-empty result only for the last block of each withrawal epoch.**

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| blockId  | String  | yes         | Block ID       |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/block/getFeePayments' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"blockId":"99e4a42fce9befd560cbbb515d9a692b7dd5d32a3491fa9325c43580c9f1b4fc"}'

**Example response**

    {
        "result" : {            
            "feePayments" : [
                {
                "address" : "c49dedc85a2c360fea781bcea2bc5d58fde19",
                "value" : 2000000
                }
            ]
        }
    }



