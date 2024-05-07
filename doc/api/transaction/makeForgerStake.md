[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/makeForgerStake

Creates and signs a transaction to create a forger stake.\
Can be performed by both the forger and by other delegators.

> [!IMPORTANT]
> This endpoint is deprecated and disabled from EON 1.4.0. 
> Same action will be possible through the native smart contract method delegate on [ForgerStakesV2](/doc/nativesc/contracts/ForgerStakesV2.md)

**Parameters**

See request body below.

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/makeForgerStake' -H 'Content-Type: application/json' -H 'accept: application/json' -d <requestBody>

The request body format is like this:

    {
        "forgerStakeInfo": {
            "ownerAddress": owner_address,  //this will be the address allowed to spend the forge stake lately
            "blockSignPublicKey": blockSignPubKey, //together with vrfPubKey identifies the forger
            "vrfPubKey": vrf_public_key,
            "value": amount  // in zentoshi
         },
        "nonce": nonce
    }

**Example response**

{
    "transactionId": "xxxxxxxxxxxxxxxxx"
}