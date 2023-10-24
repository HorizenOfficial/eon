[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/allWithdrawalRequests

Returns the list of the withdrawal requests assigned to a specific withdrawal epoch.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| epochNum  | integer  | yes         | Withdrawal Epoch number 

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/allWithdrawalRequests' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"epochNum": 1191}'

**Example response**

    {
        "result" : {
            "listOfWR" : [ {
            "proposition" : {
                "mainchainAddress" : "ztYQpCcqUqd8LMFiM9p7Zp4hRSkjqrcWAsu"
            },
            "value" : 1000000000000000000,
            "valueInZennies" : 100000000
            } ]
        }
    }