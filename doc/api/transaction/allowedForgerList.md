[&lt; EON API Documentation](/doc/api/index.md) 
### transaction/allowedForgerList

Returns the list of the initial allowed forgers, tracking also their votes to open the forgers' list (when the majority have voted to open forging, everyone will be allowed to stake and partecipate in forging).

**Parameters**

No parameters

**Example request**

    curl -sX POST 'http://127.0.0.1:9085/transaction/allowedForgerList' -H 'Content-Type: application/json' -H 'accept: application/json' 

**Example response**

    {
    "result" : {
        "allowedForgers" : [ {
        "blockSign" : {
            "publicKey" : "041e38dc04de208df1c05eeee8a91b92e4336e11f5113b6505dd745df417b4ae"
            },
            "vrfPubKey" : {
                "publicKey" : "a6b64b0b6eff71b6514d9893d730664ef2297302db4f86e32280f270b5e4370a00"
            },
            "openForgersVote" : 1
        }, {
        "blockSign" : {
            "publicKey" : "0ca238f98dcedcca505e75c31124a298b4dd050c51e50a8b9ad2faaeed29e541"
            },
            "vrfPubKey" : {
                "publicKey" : "0cccfd640ac53ceba44ca5bfd5b1f8bdb7323969e474a7886496a9762dc01e3d80"
            },
            "openForgersVote" : 1
        },
        {
        "blockSign" : {
            "publicKey" : "5e64c00f26a66e43029240a502417cfadee5caebbfc10d32bfe475d1215e80af"
            },
            "vrfPubKey" : {
                "publicKey" : "5b4293e3e9dd823d512409bd70ec41802466d92420c6ae944ffe7e388532c21200"
            },
            "openForgersVote" : 0
        }
         ]
    }
    }