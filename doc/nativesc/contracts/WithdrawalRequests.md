[&lt; EON Native Smart Contracts Documentation](/doc/nativesc/index.md) 
### WithdrawalRequests

Allows to request a new withdrawal of funds to the mainchain (also called backward transfer), and see the list of the previous executed ones.

|    |    | 
| --------             | -------      | 
| Contract address:    | 0x0000000000000000000011111111111111111111   | 
| ABI descriptor:       | [Click here](/doc/nativesc/contracts/WithdrawalRequests.json)   |
| Solidity interface:       | [Click here](/doc/nativesc/contracts/WithdrawalRequests.sol)   |

  

**Methods available**

- getBackwardTransfers

          function getBackwardTransfers(uint32 withdrawalEpoch) external view returns (WithdrawalRequest[] memory);
  
     Return a list of all the backward transfers executed in a specific withdrawal epoch.

- backwardTransfer

          function backwardTransfer(MCAddress mcAddress) external payable returns (WithdrawalRequest memory);

    Add a new withdrawal request: if the transaction will be executed, the backward transfer will not be immediately sent to the mainchain but will be enqued to be processed at the end of the withdrawal epoch, when all the requests will be packed into a  certificate and sent to the manchain for approval.  
    **Important**: the mcAddress parameter is not directly the mainchain address but its Pay to Script Hash (20 bytes)

    







