[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/createKeyRotationTransaction

Creates and signs sidechain transaction for signers or masters certificate submitter key rotation.

**Parameters**

See reuquest body below.


**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/createKeyRotationTransaction' -H 'Content-Type: application/json' -H 'accept: application/json' -d 'xxxxxx'

The request body format is like this:

    {
        "keyType": 0,  //Key type - 0 for signers key, 1 for masters key
        "keyIndex": 0,  //Index of certificate submitter key
        "newKey": "xxxxxxxxxxxx",
        "signingKeySignature": "xxxxxxxxxxxxxx",
        "masterKeySignature": "xxxxxxxxxxxxxxxxxx",
        "newKeySignature": "xxxxxxxxxxxxxxxxxxxxxxxx",
        "nonce": 0,
        "gasInfo": {
            "gasLimit": 10000,
            "maxFeePerGas": 100,
            "maxPriorityFeePerGas": 100
        }
    }

**Example response**

 