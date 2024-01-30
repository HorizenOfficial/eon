[&lt; EON Native Smart contracts Documentation](/doc/nativesc/index.md) 
### ForgerStakes

This native smartcontract manages the forger stakes.

|    |    | 
| --------             | -------      | 
| Contract address:    | 0x0000000000000000000022222222222222222222   | 
| ABI descriptor:       | [Click here](/doc/nativesc/contracts/ForgerStakes.json)   |
| Solidity interface:       | [Click here](/doc/nativesc/contracts/ForgerStakes.sol)   |

  

**Methods availables**

- getAllForgersStakes

          function getAllForgersStakes() external view returns (StakeInfo[] memory);
  
     Return a list of all forgers stakes present.

- delegate

          function delegate(bytes32 publicKey, bytes32 vrf1, bytes1 vrf2, address owner) external payable returns (StakeID);

     Create a new stake and assign it to the forger identified by the specified pubblic key + vrf key.  
     Vrf key is split in two separate parameters, being long more than 32bytes.  
     The owner parameter is the address authorized to remove the stake by calling the withdraw founctions.
         
- withdraw

          function withdraw(StakeID stakeId, bytes1 signatureV, bytes32 signatureR, bytes32 signatureS) external returns (StakeID);
  
     Remove the stake identified by stakeId and withdraw the founds, by providing the correct signature.  
     The message to sign is composed by the concatenation of stakeId + sender address + invocation nonce, and is verified against the owner of the stake.  
     Note: the whole amount staked will be removed, it is not allowd to remove only partially a stake.

- openStakeForgerList

          function openStakeForgerList(uint32 forgerIndex, bytes32 signature1, bytes32 signature2) external returns (bytes memory);
  
     Execute a transaction  expressing the vote for opening the restricted forgers list.
     This transaction is allowed only when the forgers are initially restricted, and can be executed only by one of the allowed forgers.  
     The forger index is determined by the position of the forger in the allowed forger list.  
     The message to sign is composed by the concatenation of foreger index + sender address + invocation nonce, and is verified against the blockSignerProposition.


    

    

    

    
    





