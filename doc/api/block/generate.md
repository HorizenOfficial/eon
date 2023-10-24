[&lt; EON API Documentation](/doc/api/index.md) 
### block/generate

Tries to generate new block by epoch and slot number. Returns id of generated sidechain block.
**This endpoint can be used only in REGTEST mode**

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| epochNumber  | int  | yes         | Epoch Number  |
| slotNumber  | int  | yes         | Slot number ID       |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/block/generate' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"epochNumber":"1", "slotNumber":"100"}' 

**Example response**

    {
        "result": {
            "blockId": "7f25d35aadae65062033757e5049e44728128b7405ff739070e91d753b419094"
        }
    }





