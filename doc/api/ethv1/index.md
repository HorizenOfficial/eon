[&lt; EON API Documentation](/doc/api/index.md) 
### /ethv1

Executes Ethereum RPC compatible methods.\
Returns the success / error response of called RPC method or error if method does not exist.\
The request/response objects format follows JSON-RPC 2.0 specification.

For more info on the available RPC commands, you can look at:\
[https://postman.horizenlabs.io/](https://postman.horizenlabs.io/)


**Example request**

    curl --request POST 'http://127.0.0.1:9085/ethv1' \
                                                --header 'Accept: application/json' \
                                                --header 'Content-Type: application/json' \
                                                --data-raw '{
                                                    "jsonrpc":"2.0",
                                                    "method":"eth_getBalance",
                                                    "params":["0xdd270b03A04A06A4432F0eDEbcFE1e0C640bc55d"],
                                                    "id":1
                                                }'  


**Example response**

    {
        "jsonrpc" : "2.0",
        "id" : 1,
        "result" : "0x0"
    }