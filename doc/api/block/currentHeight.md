[&lt; EON API Documentation](/doc/api/index.md) 
### block/currentHeight

Return here best sidechain block height in active chain

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/block/currentHeight' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "height" : 449138
        }
    }





