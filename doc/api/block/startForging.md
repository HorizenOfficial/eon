[&lt; EON API Documentation](/doc/api/index.md) 
### block/startForging

Start forging activity: the node will start to partecipate at the forgers lottery on every slot.\n
The probability of being elected as forge leader and being able to propose a block is proportional to the owned stake. 

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/block/startForging' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {}
    }





