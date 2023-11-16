[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/getKeysOwnerScAddresses

Return the list of all EON sidechain addresses that have at least one mainchain associated. 
This function is used for voting pourposes in ZENDAO.

**Parameters**

No parameter needed.


**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/getKeysOwnerScAddresses' -H 'Content-Type: application/json' -H 'accept: application/json' 
    
**Example response**

    {
        "owners": ["<eon_address1>", "<eon_address2>", ...]
    }