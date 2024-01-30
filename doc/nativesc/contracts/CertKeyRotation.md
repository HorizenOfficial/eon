[&lt; EON Native Smart contracts Documentation](/doc/nativesc/index.md) 
### CertKeyRotation

This native smartcontract is used to rotate the master keys of the EON certifiers.

|    |    | 
| --------             | -------      | 
| Contract address:    | 0x0000000000000000000044444444444444444444   | 
| ABI descriptor:       | [Click here](/doc/nativesc/contracts/CertKeyRotation.json)   |
| Solidity interface:       | [Click here](/doc/nativesc/contracts/CertKeyRotation.sol)   |

  

**Methods availables**

- submitKeyRotation

          function submitKeyRotation(uint32 key_type, uint32 index, bytes32 newKey_1, bytes1 newKey_2, bytes32 signKeySig_1, bytes32 signKeySig_2, bytes32 masterKeySig_1, bytes32 masterKeySig_2, bytes32 newKeySig_1, bytes32 newKeySig_2) external returns (uint32, uint32, bytes32, bytes1, bytes32, bytes32, bytes32, bytes32);
  
     Exectue a signers or masters certificate submitter key rotation.





