[&lt; EON Native Smart Contracts Documentation](/doc/nativesc/index.md) 
### ForgerStakes

This native smart contract manages the forger stakes.

|    |    | 
| --------             | -------      | 
| Contract address:    | 0x0000000000000000000022222222222222222222   | 
| ABI descriptor:       | [Click here](/doc/nativesc/contracts/ForgerStakes.json)   |
| Solidity interface:       | [Click here](/doc/nativesc/contracts/ForgerStakes.sol)   |

  

**Methods available**

- getAllForgersStakes

          function getAllForgersStakes() external view returns (StakeInfo[] memory);
  
     Return a list of all forgers stakes present.

- delegate

          function delegate(bytes32 publicKey, bytes32 vrf1, bytes1 vrf2, address owner) external payable returns (StakeID);

     Create a new stake and assign it to the forger identified by the specified public key + vrf key.  
     Vrf key is split in two separate parameters, being longer than 32 bytes.  
     The owner parameter is the address authorized to remove the stake by calling the withdraw functions.
     The amount of the stake is specified in the "value" field of the transaction.
         
- withdraw

          function withdraw(StakeID stakeId, bytes1 signatureV, bytes32 signatureR, bytes32 signatureS) external returns (StakeID);
  
     Remove the stake identified by stakeId and withdraw the funds, by providing the correct signature.  
     The message to sign is composed by the concatenation of stakeId + sender address + invocation nonce, and is verified against the owner of the stake.  
     Note: the whole amount staked will be removed, it is not allowed to remove only partially a stake.

- openStakeForgerList

          function openStakeForgerList(uint32 forgerIndex, bytes32 signature1, bytes32 signature2) external returns (bytes memory);
  
     Execute a transaction expressing the vote for opening the restricted forgers list.
     This transaction is allowed only when the forgers are initially restricted, and can be executed only by one of the allowed forgers.  
     The forger index is determined by the position of the forger in the allowed forger list.  
     The message to sign is composed by the concatenation of forger index + sender address + invocation nonce, and is verified against the blockSignerProposition.

- upgrade

          function upgrade() external view returns (uint32);

     This method upgrades the model of the forger stakes storage. It can be called just once. If successful, it returns 
     the number identifying the new storage version (1 => Version 2). It emits a StakeUpgrade event, with the storage 
     versions before and after the upgrade.

- getPagedForgersStakesByUser

          function function getPagedForgersStakesByUser(address owner, uint32 startIndex, uint32 pageSize) external view returns (uint32, StakeInfo[] memory);

  Returns the first "pageSize" forger stakes, owned by the specified address, starting from "startIndex". In case there 
  are additional stakes left, it returns the index of the first of the remaining stakes, otherwise it returns -1.
  This method requires the Forger Stake storage model version 2, so it will fail if invoked before the “upgrade()” method.

- stakeOf

          function stakeOf(address owner) external view returns (uint256);

  Returns the total amount of forger stakes owned by the specified address. This method requires the Forger Stake 
  storage model version 2, so it fails when invoked before the “upgrade()”  method.

    

    

    

    
    





