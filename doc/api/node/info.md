[&lt; EON API Documentation](/doc/api/index.md) 
### node/info

Returns info about this node.

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/info' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "nodeName" : "evmapp-testnet_forger1",
            "nodeType" : "forger,signer,submitter",
            "protocolVersion" : "0.0.1",
            "agentName" : "2-Hop",
            "sdkVersion" : "sidechains-sdk/0.8.0-SNAPSHOT/amd64/jdk11",
            "nodeVersion" : "dev",
            "scId" : "1f758350754c12ac8f75a547f745b75eb744b382e15d0d3b0e24a4b5c5acde00",
            "scType" : "non ceasing",
            "scModel" : "Account",
            "scBlockHeight" : 976649,
            "scConsensusEpoch" : 1774,
            "epochForgersStake" : 1200110000,
            "nextBaseFee" : 20000000000,
            "scWithdrawalEpochLength" : 100,
            "scWithdrawalEpochNum" : 1185,
            "scEnv" : "testnet",
            "lastMcBlockReferenceHash": "0000612c0dcffbd60108068537287d12efe8e33a06f51c6145ae0c8d548ac452",
            "numberOfPeers" : 15,
            "numberOfConnectedPeers" : 14,
            "numberOfBlacklistedPeers" : 0,
            "maxMemPoolSlots" : 6144,
            "numOfTxInMempool" : 0,
            "executableTxSize" : 0,
            "nonExecutableTxSize" : 0,
            "lastCertEpoch" : 1184,
            "lastCertQuality" : 9,
            "lastCertBtrFee" : 0,
            "lastCertFtMinAmount" : 54,
            "lastCertHash" : "6a3c0d3c83391d58f353f3218aef75abc9fbe1d7c820df2666dde7620edc4b70",
            "errors" : [ ]
        }





