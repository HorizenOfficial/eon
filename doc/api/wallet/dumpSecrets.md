[&lt; EON API Documentation](/doc/api/index.md) 
### wallet/dumpSecrets

Create locally a dump file of all the secrets (privatekeys) contained in  the node wallet.

**Parameters**

| Name     | Type    | Required    | Description    |
| -------- | ------- | -------     | -------        | 
| path  | string  | yes         | Local full path of the file to be created (folder must be present)  |

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/wallet/dumpSecrets' -H 'Content-Type: application/json' -H 'accept: application/json' -d '{"path":"/tmp/secrets.dump"}'  

**Example response**

    {
        "result" : {
            "status" : "Secrets dump completed successfully at: /tmp/secrets.dump"
        }
    }