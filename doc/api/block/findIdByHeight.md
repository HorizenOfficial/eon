[&lt; EON API Documentation](/doc/api/index.md) 
### block/findIdByHeight

Returns a sidechain block Id by its height in the active chain

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| height  | int  | yes         | Height in the blockchain    |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/block/findIdByHeight' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"height":"100"}'

**Example response**

    {
    "result" : {
        "blockId" : "56dbfa664a959c5d0ab79ecf8eb25b5f87f1b102f653608c3d9d05b4a6315f04"
    }






