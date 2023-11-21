[&lt; EON API Documentation](/doc/api/index.md) 
### block/best

Returns best sidechain block and height in active chain

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/block/best' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "block" : {
            "header" : {
                "version" : 2,
                "parentId" : "f903f9ad5f5236d55104701ec56d0b8166774faac5850f76fd4f7e01b7a447fa",
                "timestamp" : 1687640542,
                "forgingStakeInfo" : {
                "blockSignPublicKey" : {
                    "publicKey" : "5e64c00f26a66e43029240a502417cfadee5caebbfc10d32bfe475d1215e80af"
                },
                "vrfPublicKey" : {
                    "publicKey" : "5b4293e3e9dd823d512409bd70ec41802466d92420c6ae944ffe7e388532c21200"
                },
                "stakeAmount" : 100000000
                },
                "forgingStakeMerklePath" : "0800a5d76ef1d740504e91c5d5c9acf98ddfa2bd92ac24115c82829b9715e39f36b00188cdbc0e54bd0b991a455ec668170ffd898e9b7dea8ea86c030af32afc5b9a0f00039b9b4e818a6a1fcedef08bb70e406bd66708017ae1d6a21afa86c93e3afce4010ac631d99b7a1063dd0a99839c9b76f2b11106eaed0dd4c14a1b96e1d58b103f",
                "vrfProof" : {
                "vrfProof" : "e650b28a892c853dfdd41ab6633772050d598e83fb551542ab1691baec90092f80ef904e7bcfa1d8985d137c9ba6a9b71e858ea65fb64d1cce0bb13cd38fd4ce373bfef444d762f3c4a3e1a4f3446085502ba5336574fcd537fd6313b28bcef43c"
                },
                "vrfOutput" : {
                "bytes" : "0eced5bf9063ae048a7f699c5a8ea544ab4d2f2d9e8cc13c3a85177bbef33339"
                },
                "sidechainTransactionsMerkleRootHash" : "56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",
                "mainchainMerkleRootHash" : "0000000000000000000000000000000000000000000000000000000000000000",
                "stateRoot" : "cb18d6a817a1b46fb8ade500081b9fe563e940914e2c37fe9c52bedc116b183d",
                "receiptsRoot" : "56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",
                "forgerAddress" : {
                "address" : "52e2ab93d8d893575c70b72ba59d1da8b7f2c146"
                },
                "baseFee" : 20000000000,
                "gasUsed" : 0,
                "gasLimit" : 10000000,
                "ommersMerkleRootHash" : "0000000000000000000000000000000000000000000000000000000000000000",
                "ommersCumulativeScore" : 0,
                "feePaymentsHash" : "56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",
                "logsBloom" : {
                "bytes" : "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
                },
                "signature" : {
                "signature" : "99eb78f2b3356fa6f6f2223b47d03f1c7e1f8a86e7896e195ecf1f1c49dedc85a2c360fea781bcea2bc5d58fde19d3e2f2501959cff206cee891bc654e301700"
                },
                "id" : "0b8176408f25d94f8a2bfbc2fce233a1f8c23935e79a3a8f6c419bd4a89dfc4e"
            },
            "sidechainTransactions" : [ ],
            "mainchainBlockReferencesData" : [ ],
            "mainchainHeaders" : [ ],
            "ommers" : [ ],
            "timestamp" : 1687640542,
            "parentId" : "f903f9ad5f5236d55104701ec56d0b8166774faac5850f76fd4f7e01b7a447fa",
            "id" : "0b8176408f25d94f8a2bfbc2fce233a1f8c23935e79a3a8f6c419bd4a89dfc4e",
            "size" : 919
            },
            "height" : 408032
        }





