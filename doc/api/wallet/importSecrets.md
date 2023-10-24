[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/importSecrets

Import all the secret from a file obtained by a [wallet/dumpSecrets](/doc/api/wallet/dumpSecrets.md) call.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| path  | string  | yes         | Local full path of the file to be imported )  |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/importSecrets' -H 'Content-Type: application/json' -H 'accept: application/json'  -d '{"path":"/tmp/secrets.dump"}'  

**Example response**

    {
        "result" : {
            "successfullyAdded" : 2,
            "failedToAdd" : 1,
            "summary" : [ {
            "lineNumber" : 3,
            "description" : "requirement failed: Key already exists - PrivateKeySecp256k1{privateKey=acb2dc78}"
            } ]
        }
    }
