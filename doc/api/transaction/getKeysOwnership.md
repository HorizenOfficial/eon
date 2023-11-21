[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/getKeysOwnership

Return the list of Horizen mainchain addresses associated to a given EON sidechain addres.\
This function is used for voting pourposes in ZENDAO.

**Parameters**

| Name     | Type    | Required  | Description    |
| -------- | ------- | -------   | -------        | 
| scAddressOpt  | String  | no         | EON address to look. If omitted, all the mainchain associations  are returned |



**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/getKeysOwnership' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"scAddressOpt":"<sidechain_address>"}'

**Example response**

    {
        "keysOwnership": {
            "<sidechain address>": ["<mainchain_address1>", "<mainchain_address2>", ...]
        }
    }