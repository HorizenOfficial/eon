// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 Native Contract managing forgers stakes - Version 2 (activated from EON version 1.4)
 contract address: 0x0000000000000000000022222222222222222333
*/
interface ForgerStakesV2 {

    // Event declaration
    // Up to 3 parameters can be indexed.
    // Indexed parameters help you filter the logs by the indexed parameter
    event RegisterForger(address indexed sender, bytes32 signPubKey, bytes32 indexed vrf1, bytes1 indexed vrf2, uint256 value, uint32 rewardShare, address reward_address);
    event UpdateForger(address indexed sender, bytes32 signPubKey, bytes32 indexed vrf1, bytes1 indexed vrf2, uint32 rewardShare, address reward_address);
    event DelegateForgerStake(address indexed sender, bytes32 signPubKey, bytes32 indexed vrf1, bytes1 indexed vrf2, uint256 value);
    event WithdrawForgerStake(address indexed sender, bytes32 signPubKey, bytes32 indexed vrf1, bytes1 indexed vrf2, uint256 value);
    event ActivateStakeV2();


    //Data structures
    struct ForgerInfo {
        bytes32 signPubKey;
        bytes32 vrf1;
        bytes1 vrf2;
        uint32 rewardShare;
        address reward_address;
    }

    struct StakeDataDelegator {
        address delegator;
        uint256 stakedAmount;
    }

    struct StakeDataForger {
        bytes32 signPubKey;
        bytes32 vrf1;
        bytes1 vrf2;
        uint256 stakedAmount;
    }

    //read-write methods

    /*
      Register a new forger.
      rewardShare can range in [0..1000] and can be 0 if and only if rewardAddress == 0x000..00.
      Vrf key and signatures are split in two or more separate parameters, being longer than 32 bytes.
      sign1_x are the 25519 signature chunks and sign2_x are the Vfr signature chunks.
      The message to sign is the first 31 bytes of Keccak256 hash of a string formed by the concatenation
      of signPubKey+vrfKey+rewardShare+rewardAddress. rewardAddress is represented in the Eip55
      checksum format and hex strings are lowercase with no prefix.
      The method accepts WEI value: the sent value will be converted to the initial stake assigned to the forger.
      The initial stake amount must be >= min threshold (10 Zen)
    */
    function registerForger(bytes32 signPubKey, bytes32 vrfKey1, bytes1 vrfKey2, uint32 rewardShare,
        address rewardAddress, bytes32 sign1_1, bytes32 sign1_2,
        bytes32 sign2_1, bytes32 sign2_2, bytes32 sign2_3, bytes1 sign2_4) external payable;

     /*
      Updates an existing forger.
      A forger can be updated just once and only if rewardAddress == 0x000..00 and rewardShare == 0.
      See above the registerForger command for the parameters meaning.
    */
    function updateForger(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, uint32 rewardShare,
        address rewardAddress, bytes32 sign1_1, bytes32 sign1_2,
        bytes32 sign2_1, bytes32 sign2_2, bytes32 sign2_3, bytes1 sign2_4) external;

    /*
      Delegate a stake to a previously registered forger.
      Vrf key is split in two separate parameters, being longer than 32 bytes.
    */
    function delegate(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2) external payable;

    /*
      Withdraw (unstake) a previously assigned stake.
      Vrf key is split in two separate parameters, being longer than 32 bytes.
    */
    function withdraw(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, uint256 amount) external;

    //read only methods

    /*
       Returns the total stake amount, at the end of one or more consensus epochs, assigned to a specific forger.
       vrf, signKey and delegator are optional: if all are null, the total stake amount will be returned. If only
       delegator is null, all the stakes assigned to the forger will be summed.
       If vrf and signKey are null, but delegator is defined, the method will fail.
       consensusEpochStart and maxNumOfEpoch are optional: if both null, the data at the current consensus epoch is returned.
       Be aware that following convention applies when we talk about 'null' values: for bytes parameters, as addresses or keys etc., a byte array of the expected length with all 0 values is interpreted as null, eg "0x0000000000000000000000000000000000000000" for addresses.
       For consensusEpochStart and maxNumOfEpoch, it is 0.
       Returned array contains also elements with 0 value. Returned values are ordered by epoch, and the array length may
       be < maxNumOfEpoch if the current consensus epoch is < (consensusEpochStart + maxNumOfEpoch).
    */
    function stakeTotal(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, address delegator, uint32 consensusEpochStart, uint32 maxNumOfEpoch) external view returns (uint256[] memory listOfStakes);

    /*
       Return total sum paid to the forger reward_address at the end of one or more consensus epochs.
       Returned array contains also elements with 0 value. Returned values are ordered by epoch, and the array length may
       be < maxNumOfEpoch if the current consensus epoch is < (consensusEpochStart + maxNumOfEpoch).
    */
    function rewardsReceived(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, uint32 consensusEpochStart, uint32 maxNumOfEpoch) external view returns (uint256[] memory listOfRewards);

    /*
       Returns the  first consensus epoch when a stake is present for a specific delegator.
       signPubKey, vrf1, vrf2 and delegator parameters are mandatory.
       If no stake has been found (the delegator never staked anything to this forger) the method returns -1
    */
    function stakeStart(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, address delegator) external view returns (int32 consensusEpochStart);

    /*
      Returns the info of a specific registered forger.
    */
    function getForger(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2) external view returns (ForgerInfo memory forgerInfo);

    /*
      Returns the paginated list of all the registered forgers.
      Each element of the list is the detail of a specific forger.
      nextIndex will contain the index of the next element not returned yet. If no element is still present, next will be -1.
    */
    function getPagedForgers(int32 startIndex, int32 pageSize) external view returns (int32 nextIndex, ForgerInfo[] memory listOfForgerInfo);

    /*
      Returns the paginated list of stakes delegated to a specific forger, grouped by delegator address.
      Each element of the list is the total amount delegated by a specific address.
      nextIndex will contain the index of the next element not returned yet. If no element is still present, next will be -1.
      The returned array length may be less than pageSize even if there are still additional elements because stakes with 0 amount are filtered out.
    */
    function getPagedForgersStakesByForger(bytes32 signPubKey, bytes32 vrf1, bytes1 vrf2, int32 startIndex, int32 pageSize) external view returns (int32 nextIndex, StakeDataDelegator[] memory listOfDelegatorStakes);

    /*
      Returns the paginated list of stakes delegated by a specific address, grouped by forger.
      Each element of the list is the total amount delegated to  a specific forger.
      nextIndex will contain the index of the next element not returned yet. If no element is still present, next will be -1.
      The returned array length may be less than pageSize even if there are still additional elements because stakes with 0 amount are filtered out.
    */
    function getPagedForgersStakesByDelegator(address delegator, int32 startIndex, int32 pageSize) external view returns (int32 nextIndex, StakeDataForger[] memory listOfForgerStakes);

    /*
    /  Returns the current consensus epoch.
    */
    function getCurrentConsensusEpoch() external view returns (uint32 epoch);

    function activate() external;
}