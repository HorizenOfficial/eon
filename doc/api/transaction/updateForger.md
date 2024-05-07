[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/updateForger

Update an exisitng forger.<br>
Available from: EON 1.4.0<br>

Note: this action can be performed only for forgers with rewardShare = 0 and rewardAddress not set, and only to assign them a value.<br>

**Parameters**

| Name     | Type    | Required  | Description    |
| -------- | ------- | -------   | -------        | 
| blockSignPubKey | string | yes | Key of this forger (private key must be in the local wallet) |
| vrfPubKey | string |yes | Vrfkey of this forger(private key must be in the local wallet) |
| rewardShare     | integer | yes | Reward to be redirected to a separate reward address (integer, range from 0 to 1000 - where 1000 represents 100%) |
| rewardAddress   | string | yes  | External reward address (may be a single EOA or (more likely) a smart contract handling rewards distribution to delegators) |
| nonce    | integer | no        | Nonce associated to the address that is sending the tx. If omitted the next valid nonce will be calculated automatically.  |
| gasInfo  | object  | no        | Info about GAS |

Parameters of the gasInfo object:

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| gasLimit  | biginteger  | yes         | GAS limit |
| maxPriorityFeePerGas  | biginteger  | yes         | Max priority fee|
| maxFeePerGas  | biginteger  | yes         | Max fee per gas |

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/updateForger' -H 'Content-Type: application/json' -H 'accept: application/json'  -d <requestBody>

The request body format is like this:

    {
        "blockSignPubKey": "10e9b5236a56cddb9f0332e9dd6d69151494f24172b26ab24a27473bbc92a181",
        "vrfPubKey": "6a376f8a88b386f69296baa0792641d393c85a19b28dfd4a11d8f0a74618873280",
        "rewardShare": "234",
        "rewardAddress": "62b1bc6fd237b775138d910274ff2911d7aea5cc",      
        "stakedAmount": "100000000000",   
    }


**Example response**

    {
        "transactionId": "xxxxxxxxxxxxxxxxx"
    }