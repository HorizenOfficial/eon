[&lt; EON Native Smart Contracts Documentation](/doc/nativesc/index.md) 
### ForgerStakesV2

This native smart contract manages the forger stakes from EON 1.4.0 version.

|    |    | 
| --------             | -------      | 
| Contract address:    | 0x0000000000000000000022222222222222222333   | 
| ABI descriptor:       | [Click here](/doc/nativesc/contracts/ForgerStakesV2.json)   |
| Solidity interface:       | [Click here](/doc/nativesc/contracts/ForgerStakesV2.sol)   |

  

**Methods available**

- registerForger

          function registerForger(bytes32 signPubKey, bytes32 vrfKey1, bytes1 vrfKey2, uint32 rewardShare,
        address rewardAddress, bytes32 sign1_1, bytes32 sign1_2,
        bytes32 sign2_1, bytes32 sign2_2, bytes32 sign2_3, bytes1 sign2_4) external payable;
  
     Register a new forger.
     rewardShare can range in [0..1000] and can be 0 if and only if rewardAddress == 0x000..00.<br>
     Vrf key and signatures are split in two or more separate parameters, being longer than 32 bytes.<br>
     sign1_x are the 25519 signature chunks and sign2_x are the Vfr signature chunks.<br>
     The message to sign is the first 31 bytes of Keccak256 hash of a string formed by the concatenation
     of signPubKey+vrfKey+rewardShare+rewardAddress. rewardAddress is represented in the Eip55
     checksum format and hex strings are lowercase with no prefix.<br>
     The method accepts WEI value: the sent value will be converted to the initial stake assigned to the forger.<br>
     The initial stake amount must be >= min threshold (10 Zen)

- updateForger

          function updateForger(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, uint32 rewardShare, address rewardAddress, bytes32 signature1, bytes32 signature2) external;

     Updates an existing forger.<br>
     A forger can be updated just once and only if rewardAddress == 0x000..00 and rewardShare == 0.<br>
     Vrf key is split in two separate parameters, being longer than 32 bytes.

- delegate

          function delegate(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2) external payable;
  
     Delegates a stake to a previously registered forger.<br>
     Vrf key is split in two separate parameters, being longer than 32 bytes.<br>
     All the ZEN sent with the transaction will be delegated, and the owner will be the sender address.

- withdraw

          function withdraw(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, uint256 amount) external;
  
     Withdraws (unstake) a previously assigned stake.<br>
     Vrf key is split in two separate parameters, being longer than 32 bytes.<br>
     The amount is added to the balance of the sender of the transaction.

- stakeTotal

          function stakeTotal(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, address delegator, uint32 consensusEpochStart, uint32 maxNumOfEpoch) external view returns (uint256[] memory listOfStakes);

     Returns the total stake amount, at the end of one or more consensus epochs, assigned to a specific forger.<br>
     vrf, signKey and delegator are optional: if all are null, the total stake amount will be returned. If only
     delegator is null, all the stakes assigned to the forger will be summed.<br>
     If vrf and signKey are null, but delegator is defined, the method will fail.<br>
     consensusEpochStart and maxNumOfEpoch are optional: if both null, the data at the current consensus epoch is returned.
     Be aware that following convention applies when we talk about 'null' values: for bytes parameters, as addresses or keys etc., a byte array of the expected length with all 0 values is interpreted as null, eg "0x0000000000000000000000000000000000000000" for addresses.<br>
     For consensusEpochStart and maxNumOfEpoch, it is 0.<br>
     Returned array contains also elements with 0 value. Returned values are ordered by epoch, and the array length may
     be < maxNumOfEpoch if the current consensus epoch is < (consensusEpochStart + maxNumOfEpoch).


- rewardsReceived

          function rewardsReceived(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, uint32 consensusEpochStart, uint32 maxNumOfEpoch) external view returns (uint256[] memory listOfRewards);

     Returns total sum paid to the forger reward_address at the end of one or more consensus epochs.<br>
     Returned array contains also elements with 0 value. Returned values are ordered by epoch, and the array length may
     be < maxNumOfEpoch if the current consensus epoch is < (consensusEpochStart + maxNumOfEpoch -1).

- stakeStart

          function stakeStart(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, address delegator) external view returns (int32 consensusEpochStart);

     Returns the first consensus epoch when a stake is present for a specific delegator.<br>
     signPubKey, vrf1, vrf2 and delegator parameters are mandatory.<br>
     If no stake has been found (the delegator never staked anything to this forger) the method returns -1
 
- getForger

          function getForger(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2) external view returns (ForgerInfo memory forgerInfo);

     Returns the info of a specific registered forger.<br>
     The return data structure has the following format:

          struct ForgerInfo {
               bytes32 signPubKey;
               bytes32 vrf1;
               bytes1 vrf2;
               uint32 rewardShare;
               address reward_address;
          }

     rewardShare is an integer value 0-1000, meaning 0 => 0% and 1000 => 100%

- getPagedForgers

          function getPagedForgers(int32 startIndex, int32 pageSize) external view returns (int32 nextIndex, ForgerInfo[] memory listOfForgerInfo);

     Returns the paginated list of all the registered forgers.<br>
     Each element of the list is the detail of a specific forger (see above method getForger for a description of the data structure).<br>
     nextIndex will contain the index of the next element not returned yet. <br>If no element is still present, next will be -1.


- getPagedForgersStakesByForger

          function getPagedForgersStakesByForger(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, int32 startIndex, int32 pageSize) external view returns (int32 nextIndex, StakeDataDelegator[] memory listOfDelegatorStakes);
    
     Returns the paginated list of stakes delegated to a specific forger, grouped by delegator address.<br>
     Each element of the list is the total amount delegated by a specific address. The data structure has the following format:<br>
     The returned array length may be less than pageSize even if there are still additional elements because stakes with 0 amount are filtered out.

          struct StakeDataDelegator {
               address delegator;
               uint256 stakedAmount;
          }

     nextIndex will contain the index of the next element not returned yet. If no element is still present, next will be -1.

- getPagedForgersStakesByDelegator

          function getPagedForgersStakesByDelegator(address delegator, int32 startIndex, int32 pageSize) external view returns (int32 nextIndex, StakeDataForger[] memory listOfForgerStakes);

     Returns the paginated list of stakes delegated by a specific address, grouped by forger.<br>
     Each element of the list is the total amount delegated to  a specific forger. The data structure has the following format:<br>
     The returned array length may be less than pageSize even if there are still additional elements because stakes with 0 amount are filtered out.

     
          struct StakeDataForger {
               bytes32 signPubKey;
               bytes32 vrf1;
               bytes1 vrf2;
               uint256 stakedAmount;
          } 

     nextIndex will contain the index of the next element not returned yet. If no element is still present, next will be -1.

- getCurrentConsensusEpoch

          function getCurrentConsensusEpoch() external view returns (uint32 epoch);

     Returns the current consensus epoch.

- activate

          function activate() external;

     Activation function for this smart contract. Must be called only once after the hardfork. After the activation the old ForgerStake native smart contract will be de-activated.


    

    

    

    
    





