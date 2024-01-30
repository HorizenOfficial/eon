[&lt; EON Native Smart contracts Documentation](/doc/nativesc/index.md) 
### McAddrOwnership

This native smartcontract is used as a support to the ZenDao voting system.  
It allows to track associations between mainchain addresses and EON addresses, in order to sum the ZEN balances in both the chains for calculating voting powers.

|    |    | 
| --------             | -------      | 
| Contract address:    | 0x0000000000000000000088888888888888888888   | 
| ABI descriptor:       | [Click here](/doc/nativesc/contracts/McAddrOwnership.json)   |
| Solidity interface:       | [Click here](/doc/nativesc/contracts/McAddrOwnership.sol)   |

  

**Methods availables**

- getAllKeyOwnerships

          function getAllKeyOwnerships() external view returns (McAddrOwnershipData[] memory);
  
     Return a list of all the mainchain keys associated with the EON address that invoked the method.

- getKeyOwnerships

          function getKeyOwnerships(address scAddress) external view returns (McAddrOwnershipData[] memory);

     Return a list of the mainchain keys associated with the EON address specified in the input parameter scAddress

- getKeyOwnerScAddresses

          function getKeyOwnerScAddresses() external view returns (address[] memory);

    Return the list of all the EON addresses with recorded associations to mainchain keys.

- sendKeysOwnership

          function sendKeysOwnership(bytes3 mcAddrBytes1, bytes32 mcAddrBytes2, bytes24 signature1, bytes32 signature2, bytes32 signature3) external returns (bytes32);

    Associate a mainchain address to the EON address that invoked the method.  
    Mainchain address is split in 2 parameters, being long more than 32bytes.  
    Signature is split in 3 parameters for the same reason. The message to sign is the string representation of the EON address (format EIP-55: Mixed-case checksum address encoding).
    In case of success, the returned value is the id of the new ownership record created.  
    
- sendMultisigKeysOwnership

          function sendMultisigKeysOwnership(string memory mcMultisigAddress, string memory redeemScript, string[] memory mcSignatures) external returns (bytes32);

    Associate the specified mainchain multisig address to the EON address that invoked the method.  
    Redeem script and signatures must be provided as well. 
    In case of success, the returned value is the id of the new ownership record created.

- removeKeysOwnership

          function removeKeysOwnership(bytes3 mcAddrBytes1, bytes32 mcAddrBytes2) external returns (bytes32);

     Remove an association between the EON address that invoked the method and the specified mainchain address.  
     Mainchain address is split in 2 parameters, being long more than 32bytes.  
     In case of success, the returned value is the id of the  ownership record removed.

    

    

    





