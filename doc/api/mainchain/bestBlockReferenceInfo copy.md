[&lt; EON API Documentation](/doc/api/index.md) 
### mainchain/bestBlockReferenceInfo

Returns info about the most recent mainchain block reference included in the sidechain 

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/mainchain/bestBlockReferenceInfo' -H 'Content-Type: application/json' -H 'accept: application/json'  

**Example response**

    {
    "result" : {
        "blockReferenceInfo" : {
        "mainchainHeaderSidechainBlockId" : "2abcf1ffa5e99aadbe15a9387e70d485d64cdb5b1ae842fcc60e1f8b1f0c17da",
        "mainchainReferenceDataSidechainBlockId" : "2abcf1ffa5e99aadbe15a9387e70d485d64cdb5b1ae842fcc60e1f8b1f0c17da",
        "hash" : "00037532bda93d50f3348533dfccd6ce2865c083bd3843d6fe9c5bb0b3b2e034",
        "parentHash" : "0000898ffe9dabd5435a772e8f3385193829f567acef873a3bf549ddee882a0c",
        "height" : 1355909
        }
    }
    }