[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/createEIP1559Transaction

Creates and signs an EIP155 transaction.\
These are the new type2 version standard ethereum transactions with also priority fee and gasTip and with replay protection.

**Parameters**

See request body below.

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/createEIP1559Transaction' -H 'Content-Type: application/json' -H 'accept: application/json' -d <requestBody>

The request body format is like this:

    {
        "from": fromAddress,
        "to": toAddress,
        "nonce": nonce,
        "gasLimit": gasLimit,
        "maxPriorityFeePerGas": maxPriorityFeePerGas,
        "maxFeePerGas": maxFeePerGas,
        "value": value,
        "data": data,
        "signature_v": signature_v,
        "signature_r": signature_r,
        "signature_s": signature_s
    }

**Example response**

    {
        "transactionId": "xxxxxxxxxxxxxxxxx"
    }