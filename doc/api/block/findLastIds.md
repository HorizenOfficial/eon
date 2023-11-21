[&lt; EON API Documentation](/doc/api/index.md) 
### block/findLastIds

Returns an array with the ids of the last x blocks

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| number  | int  | yes         | Retrieves the last x number of block ids      |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/block/findLastIds' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"number":"5"}'

**Example response**

    {
        "result" : {
            "lastBlockIds" : 
                [ "fe9294509662cef1a781086af1e3ab2f7252f334554be70404105763f3a0cfe0", 
                "38b5b6c4a5d8f74b5a80ad01cf3e2880af9ca648f3b6f88f0b38b2a2f038d9c3",
                "6693ade391f6ef16ccc20e7e8ea2214c6f1a451dd1c0cd4fba1f4d7086ce126c", 
                "d0fcf4b95e28e43181477796c04158f0853449cb65cb6c6b4623e2674f44bd4a", 
                "0fd13ee2e29b1f9de094268aafe0acb5243948453b4dbac499417d6cb48348eb" 
                ]
    }





