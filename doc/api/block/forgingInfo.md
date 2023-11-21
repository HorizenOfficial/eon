[&lt; EON API Documentation](/doc/api/index.md) 
### block/forgingInfo

Returns forging info, including:
- conensus slots epoch lengh  and number of slots in epoch
- current epoch and slot based on best block in the history and based on the current clock
- forging enabled (yes/no)

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/block/forgingInfo' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
    "result" : {
        "consensusSecondsInSlot" : 12,
        "consensusSlotsInEpoch" : 720,
        "bestBlockEpochNumber" : 1079,
        "bestBlockSlotNumber" : 300,
        "currentEpochNumber" : 1774,
        "currentSlotNumber" : 8922,
        "forgingEnabled" : false
        }
    }






