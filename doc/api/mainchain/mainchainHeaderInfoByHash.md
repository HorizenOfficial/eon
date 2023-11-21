[&lt; EON API Documentation](/doc/api/index.md) 
### mainchain/mainchainHeaderInfoByHash

Returns info about a  mainchain block header by its hash.
Only mainchain block headers referenced by the sidechain are returned.

**Parameters**

| Name     | Type    | Required    | Description      |
| -------- | ------- | -------     | -------          | 
| hash     | string  | yes          | Mainchain block hash to query      |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/mainchain/mainchainHeaderInfoByHash' -H 'Content-Type: application/json' -H 'accept: application/json'  -d '{"hash":"00037532bda93d50f3348533dfccd6ce2865c083bd3843d6fe9c5bb0b3b2e034"}'  

**Example response**

    {
    "result" : {
        "mainchainHeaderInfo" : {
        "hash" : "00037532bda93d50f3348533dfccd6ce2865c083bd3843d6fe9c5bb0b3b2e034",
        "parentHash" : "0000898ffe9dabd5435a772e8f3385193829f567acef873a3bf549ddee882a0c",
        "height" : 1355909,
        "sidechainBlockId" : "2abcf1ffa5e99aadbe15a9387e70d485d64cdb5b1ae842fcc60e1f8b1f0c17da",
        "cumulativeCommTreeHash" : "8b02d11528132c3369d5762f569f488cb25e8cdd0db5e86ae8459e3eb15f5a2d"
        }
    }
}