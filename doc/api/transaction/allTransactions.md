[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/allTransactions

Returns the list of the transactions in mempool.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| format  | boolean  | no         | If false, only the transaction id will be returned, otherwise the whole transaction in json format

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/allTransactions' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "transactions" : [ "0134123523626tztYQpCcqUqd8LMFiM9p7Zp4hRSkjqrcWAsu"  ]
        }
    }