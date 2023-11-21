[&lt; EON API Documentation](/doc/api/index.md) 
### mainchain/genesisBlockReferenceInfo

Returns info about the mainchain block containing the transaction that created this sidechain. 

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/mainchain/genesisBlockReferenceInfo' -H 'Content-Type: application/json' -H 'accept: application/json'  

**Example response**

    {
        "result" : {
            "blockReferenceInfo" : {
            "mainchainHeaderSidechainBlockId" : "2f255cdc2f24c9fc365ca4d47d99783fce2fc369f7883a0bac9dc99227208230",
            "mainchainReferenceDataSidechainBlockId" : "2f255cdc2f24c9fc365ca4d47d99783fce2fc369f7883a0bac9dc99227208230",
            "hash" : "000cca32283b4652ea0e22883a913b5f2082e6c9e70a7d0f56e80c6f52c79cac",
            "parentHash" : "000b01ca938dd2d122b2f1d92a71a3608a3ba0aad4f099754e4738c922267f69",
            "height" : 1236923
            }
        }
    }