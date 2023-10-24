[&lt; EON API Documentation](/doc/api/index.md) 
### block/findBlockInfoById

Returns SidechainBlockInfo by its id and if the block is in the active chain or not

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| blockId  | String  | yes         | Block ID       |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/block/findBlockInfoById' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"blockId":"f4d983c008a5352c44a188d9a8d8490a85d2777b00c52976848787ef042f89c6"}'

**Example response**

    {
        "result" : {
            "blockInfo" : {
            "height" : 329027,
            "score" : 329027,
            "parentId" : "4c7ad72fcbfaf74eab72fd3e082d14efc0e4479f0e581eb454446f373b311d11",
            "timestamp" : 1686155566,
            "semanticValidity" : "Valid",
            "mainchainHeaderBaseInfo" : [ ],
            "mainchainReferenceDataHeaderHashes" : [ ],
            "withdrawalEpochInfo" : {
                "epoch" : 411,
                "lastEpochIndex" : 38
            },
            "vrfOutputOpt" : {
                "bytes" : "04bdfb773c6a8ef6197c588d25323bf9d3a789476fed797d823911e55dbc0729"
            },
            "lastBlockInPreviousConsensusEpoch" : "868e9f17953d0d3b29f1e49c7bea6969404b51bc2207f1a32e70230a5d71c7f5"
            },
            "isInActiveChain" : true
        }
    }





