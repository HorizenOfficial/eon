# EON API Documentation

Following endpoints are available on EON node:


## Ethereum RPC commands

[/ethv1](/doc/api/ethv1/index.md)

## Blocks endpoints 
[/block/findById](/doc/api/block/findById.md)\
[/block/findLastIds](/doc/api/block/findLastIds.md)\
[/block/findIdByHeight](/doc/api/block/findIdByHeight.md)\
[/block/best](/doc/api/block/best.md)\
[/block/currentHeight](/doc/api/block/currentHeight.md)\
[/block/findBlockInfoById](/doc/api/block/findBlockInfoById.md)\
[/block/getFeePayments](/doc/api/block/getFeePayments.md)\
[/block/getForwardTransfers](/doc/api/block/getForwardTransfers.md)\
[/block/startForging](/doc/api/block/startForging.md)\
[/block/stopForging](/doc/api/block/stopForging.md)\
[/block/forgingInfo](/doc/api/block/forgingInfo.md)\
[/block/generate](/doc/api/block/generate.md)

## Transaction endpoints 


[/transaction/createLegacyEIP155Transaction](/doc/api/transaction/createLegacyEIP155Transaction.md)\
[/transaction/createEIP1559Transaction](/doc/api/transaction/createEIP1559Transaction.md)\
[/transaction/createLegacyTransaction](/doc/api/transaction/createLegacyTransaction.md)\
[/transaction/sendTransaction](/doc/api/transaction/sendTransaction.md)\
[/transaction/signTransaction](/doc/api/transaction/signTransaction.md)\
[/transaction/decodeTransactionBytes](/doc/api/transaction/decodeTransactionBytes.md)\
[/transaction/createSmartContract](/doc/api/transaction/createSmartContract.md)\
[/transaction/allTransactions](/doc/api/transaction/allTransactions.md)

#### Backward transfers:

[/transaction/withdrawCoins](/doc/api/transaction/withdrawCoins.md)\
[/transaction/allWithdrawalRequests](/doc/api/transaction/allWithdrawalRequests.md)

#### Forge stakes management:

[/transaction/allForgingStakes](/doc/api/transaction/allForgingStakes.md)\
[/transaction/myForgingStakes](/doc/api/transaction/myForgingStakes.md)\
[/transaction/pagedForgingStakes](/doc/api/transaction/pagedForgingStakes.md)\
[/transaction/pagedForgersStakesByForger](/doc/api/transaction/pagedForgersStakesByForger.md)\
[/transaction/pagedForgersStakesByDelegator](/doc/api/transaction/pagedForgersStakesByDelegator.md)\
[/transaction/registerForger](/doc/api/transaction/registerForger.md)\
[/transaction/updateForger](/doc/api/transaction/updateForger.md)

Deprecated methods: 

[/transaction/makeForgerStake](/doc/api/transaction/makeForgerStake.md)\
[/transaction/spendForgingStake](/doc/api/transaction/spendForgingStake.md)

#### Restricted forgers management:

[/transaction/openForgerList](/doc/api/transaction/openForgerList.md)\
[/transaction/allowedForgerList](/doc/api/transaction/allowedForgerList.md)

#### ZENDao related:

[/transaction/sendKeysOwnership](/doc/api/transaction/sendKeysOwnership.md)\
[/transaction/getKeysOwnership](/doc/api/transaction/getKeysOwnership.md)\
[/transaction/removeKeysOwnership](/doc/api/transaction/removeKeysOwnership.md)\
[/transaction/getKeysOwnerScAddresses](/doc/api/transaction/getKeysOwnerScAddresses.md)

#### Key rotation:

[/transaction/createKeyRotationTransaction](/doc/api/transaction/createKeyRotationTransaction.md) 

## Wallet endpoints

[/wallet/createPrivateKey25519](/doc/api/wallet/createPrivateKey25519.md)\
[/wallet/createPrivateKeySecp256k1](/doc/api/wallet/createPrivateKeySecp256k1.md)\
[/wallet/createVrfSecret](/doc/api/wallet/createVrfSecret.md)\
[/wallet/allPublicKeys](/doc/api/wallet/allPublicKeys.md)\
[/wallet/getBalance](/doc/api/wallet/getBalance.md)\
[/wallet/getTotalBalance](/doc/api/wallet/getTotalBalance.md)\
[/wallet/getAllBalances](/doc/api/wallet/getAllBalances.md)\
[/wallet/importSecret](/doc/api/wallet/importSecret.md)\
[/wallet/exportSecret](/doc/api/wallet/exportSecret.md)\
[/wallet/dumpSecrets](/doc/api/wallet/dumpSecrets.md)\
[/wallet/importSecrets](/doc/api/wallet/importSecrets.md) 

## Mainchain related endpoints
[/mainchain/genesisBlockReferenceInfo](/doc/api/mainchain/genesisBlockReferenceInfo.md)\
[/mainchain/bestBlockReferenceInfo](/doc/api/mainchain/bestBlockReferenceInfo.md)\
[/mainchain/blockReferenceInfoBy](/doc/api/mainchain/blockReferenceInfoBy.md)\
[/mainchain/blockReferenceByHash](/doc/api/mainchain/blockReferenceByHash.md)\
[/mainchain/mainchainHeaderInfoByHash](/doc/api/mainchain/mainchainHeaderInfoByHash.md)

## Node management endpoints

[/node/allPeers](/doc/api/node/allPeers.md)\
[/node/connectedPeers](/doc/api/node/connectedPeers.md)\
[/node/peer](/doc/api/node/peer.md)\
[/node/info](/doc/api/node/info.md)\
[/node/sidechainId](/doc/api/node/sidechainId.md)\
[/node/storageVersions](/doc/api/node/storageVersions.md)\
[/node/connect](/doc/api/node/connect.md)\
[/node/disconnect](/doc/api/node/disconnect.md)\
[/node/addToBlacklist](/doc/api/node/addToBlacklist.md)\
[/node/removeFromBlacklist](/doc/api/node/removeFromBlacklist.md)\
[/node/blacklistedPeers](/doc/api/node/blacklistedPeers.md)\
[/node/stop](/doc/api/node/stop.md)

## Metrics endpoints
[/metrics](/doc/api/metrics/index.md)

