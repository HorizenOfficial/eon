[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/createLegacyEIP155Transaction

Creates and signs a legacy EIP155 transaction.
These are the type0 "old" legacy version ethereum transactions with replay protection.

**Parameters**

See request body below.

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/createLegacyEIP155Transaction' -H 'Content-Type: application/json' -H 'accept: application/json' -d <requestBody>

The request body format is like this:

    {
        "from": fromAddress,
        "to": toAddress,
        "nonce": nonce,
        "gasLimit": gasLimit,
        "gasPrice": gasPrice,
        "value": value,
        "data": data,
        "signature_v": signature_v,
        "signature_r": signature_r,
        "signature_s": signature_s,
        "outputRawBytes": true
    }

**Example response**

{
    "transactionId": "xxxxxxxxxxxxxxxxx"
}