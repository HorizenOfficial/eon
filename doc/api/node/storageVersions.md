[&lt; EON API Documentation](/doc/api/index.md) 
### node/storageVersions

Returns info about most recent version recorded in the internal storages.

**Parameters**

No parameters

**Example request**

     curl -sX POST 'http://127.0.0.1:9085/node/storageVersions' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
        "result" : {
            "listOfVersions" : {
                "AccountHistoryStorage" : "6fd6be262631ab9535a00b19cb8b7d7bfe398655c4a18ef044368778aa8f1746",
                "ConsensusDataStorage" : "59e813c4637b2033aef991236b2dfe49d28b94e7145caec9f61aa0bdaee6b30e",
                "AccountStateMetadataStorage" : "074d804ef1c5c028fcbd4fecd9c65400b71a3604decd03c7fbc3ebde1b1cf657",
                "SidechainSecretStorage" : "9bebf5221cf0b8f104aefc6e7f9db80fdbff595fe2ca05a4af5a290b36daf375"
            }
        }
    }






