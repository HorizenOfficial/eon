[&lt; EON API Documentation](/doc/api/index.md) 
### mainchain/blockReferenceInfoBy

Returns a specific mainchain block reference by block hash or height (in the mainchain) 
Only mainchain blocks referenced by the sidechain are returned.

**Parameters**

| Name     | Type    | Required    | Description      |
| -------- | ------- | -------     | -------          | 
| hash     | string  | no          | Mainchain block hash to query       |
| height   | int     | no          | Height in the mainchain to query  |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/mainchain/blockReferenceInfoBy' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"hash":"00037532bda93d50f3348533dfccd6ce2865c083bd3843d6fe9c5bb0b3b2e034"}'  

     curl -sX POST 'http://127.0.0.1:9085/mainchain/blockReferenceInfoBy' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"height":1355909}'    

**Example response**

    {
        "result" : {
            "blockHex" : "00037532bda93d50f3348533dfccd6ce2865c083bd3843d6fe9c5bb0b3b2e0340000898ffe9dabd5435a772e8f3385193829f567acef873a3bf549ddee882a0c8ac2a5012abcf1ffa5e99aadbe15a9387e70d485d64cdb5b1ae842fcc60e1f8b1f0c17da2abcf1ffa5e99aadbe15a9387e70d485d64cdb5b1ae842fcc60e1f8b1f0c17da"
        }
    }