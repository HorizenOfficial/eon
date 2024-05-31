// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./interfaces/ForgerStakesV2.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract DelegatedStaking is ReentrancyGuard {

    bytes32 public signPublicKey;
    bytes32 public forgerVrf1;
    bytes1 public forgerVrf2;
    ForgerStakesV2 public forger = ForgerStakesV2(0x0000000000000000000022222222222222222333);

    mapping(address => uint32) public lastClaimedEpochForAddress;
    uint32 public constant MAX_NUMBER_OF_EPOCH = 100;

    struct ClaimData {
        uint32 epochNumber;
        uint256 claimedReward;
    }
    //events
    event Claim(bytes32 signPublicKey, bytes32 indexed forgerVrf1, bytes1 indexed forgerVrf2, address indexed delegator, ClaimData[] claimData);
    //error
    error TooManyEpochs(uint256 lastClaimedEpoch, uint256 currentEpoch);
    error NothingToClaim();
    error ArraysHaveDifferentLengths();

    //constructor
    constructor(bytes32 _signPublicKey, bytes32 vrf1, bytes1 vrf2) {
        signPublicKey = _signPublicKey;
        forgerVrf1 = vrf1;
        forgerVrf2 = vrf2;
    }

    function claimReward(address payable owner) nonReentrant external {
        (uint256 totalToClaim, ClaimData[] memory claimDetails) = calcReward(owner);
        if(totalToClaim == 0) {
            revert NothingToClaim();
        }

        //update last claimed epoch
        lastClaimedEpochForAddress[owner] = claimDetails[claimDetails.length - 1].epochNumber;
        
        //transfer reward
        owner.transfer(totalToClaim);
        emit Claim(signPublicKey, forgerVrf1, forgerVrf2, owner, claimDetails);
    }

    function calcReward(address owner) public view returns(uint256 totalToClaim, ClaimData[] memory claimDetails) {
        int32 startEpochSigned = _getStartEpochForAddress(owner);
        if(startEpochSigned == -1 ) {
            return (0, new ClaimData[](0));
        }

        uint32 startEpoch = uint32(startEpochSigned);
        if(startEpoch >= forger.getCurrentConsensusEpoch()) {
            //nothing to claim 
            //we are et epoch N, delegator already claimed until N-1 OR
            //we are at an epoch that is lower than 2 (2 is minimum for startEpoch)
            return (0, new ClaimData[](0));
        }

        //get sum fees
        uint256[] memory sumFeeAccruedInEpoch = forger.rewardsReceived(signPublicKey, forgerVrf1, forgerVrf2, startEpoch, MAX_NUMBER_OF_EPOCH);
        uint32 length = uint32(sumFeeAccruedInEpoch.length);
    
        uint256[] memory delegatorStakes = forger.stakeTotal(signPublicKey, forgerVrf1, forgerVrf2, owner, startEpoch - 2, length); 
        uint256[] memory totalStakes = forger.stakeTotal(signPublicKey, forgerVrf1, forgerVrf2, address(0), startEpoch - 2, length); 

        //check lengths
        if(length != delegatorStakes.length || length != totalStakes.length) revert ArraysHaveDifferentLengths();
        
        claimDetails = new ClaimData[](length); 

        uint32 i; //loop
        uint32 epoch = startEpoch;

        while(i != length) {
            uint256 claimedReward;

            if(totalStakes[i] == 0) {
                claimedReward = 0; //avoid divison by 0
            }
            else {
                claimedReward = sumFeeAccruedInEpoch[i] * delegatorStakes[i] / totalStakes[i];
            }

            totalToClaim += claimedReward;

            claimDetails[i] = ClaimData(epoch, claimedReward);
            unchecked { ++i; ++epoch; }
        }

        return (totalToClaim, claimDetails);
    }

    function _getStartEpochForAddress(address owner) internal view returns(int32) {
        uint32 lastClaimedEpoch = lastClaimedEpochForAddress[owner];
        int32 startEpoch;
        if(lastClaimedEpoch == 0) {
            int32 stakeStartForUser = forger.stakeStart(signPublicKey, forgerVrf1, forgerVrf2, owner); 
            //start from the first epoch user has staked
            if(stakeStartForUser == -1) return -1;
            startEpoch = stakeStartForUser + 2;
        } 
        else { 
            startEpoch = int32(lastClaimedEpoch) + 1; //start from the next to claim
        }

        return startEpoch < 2 ? int32(2) : startEpoch; //nothing to claim in first two epochs due to n-2
    }
}