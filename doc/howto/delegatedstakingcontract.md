[&lt; EON Documentation index](/doc/index.md) 
# Delegated Staking contract

The Delegated Staking contract is used by Forgers to:

- Receive block rewards for staking
- Handle distribution of the rewards between the different delegators of the forger.

A [template implementation](/doc/howto/DelegatedStaking.sol) is provided for the contract.

## Template implementation details

- It should be instantiated specifying the forger's parameters:
  - `bytes32 signPubKey`
  - `bytes32 vrf1`: first 32 bytes of the 33-bytes VRF key for the forger
  - `bytes1 vrf2`: last byte of the 33-bytes VRF key for the forger

  `ForgerStakesV2` address is hardcoded to `0x0000000000000000000022222222222222222333`


- It has no `receive`, `fallback` or `payable` function: that means that it can't directly receive ZEN with a blockchain transaction, but it can receive it choosing the contract address as receiver of the forger's rewards.

- Two methods are offered for the delegator(s):
  - `calcReward(address)` returns a tuple containing the total reward that the specified address could claim at the current moment as first element; an array of `ClaimData` objects, each one containing the number of the claimable epoch paired with the amount of ZEN that is claimed for that epoch. 
  - `claimReward(address)` executes the claim for the specified address, transferring the amount calculated by `calcReward` and updating the internal state. Please note that **any** address can execute the claim for another address, if the target one is a valid delegator. The method emit a `Claim` event with the forger's identifiers, the delegator address, and the `ClaimData` array. To avoid reentrancy attacks, the method uses the `nonReentrant` modifier inherited by OpenZeppelin's `ReentrancyGuard`.

- The implementation is **not** upgradeable.

## Rewards Calculation

The rewards foe each delegator in an epoch `N` are calculated as the following:

```
reward_at_epoch_N = (total_reward_for_forger_at_N-2 * current_delegator_stakes_at_epoch_N) / total_delegator_stakes_at_epoch_N
```

That means that a user will be able to claim the rewards starting from 2 epochs after they execute the stakes.

When calculating or executing the claim, the smart contract checks if the target address actually delegated to the current forger invoking the `stakeStart` method, that returns the first valid epoch in which the delegator delegated or `-1` otherwise. Then, the smart contract calculates the claim amount for each epoch with the above formula starting from the epoch returned by `stakeStart` method if the address never claimed the rewards, or from the last epoch for which the address claimed the rewards (stored into the `lastClaimedEpochForAddress` mapping) otherwise.

To avoid to exceed block gas limit when executing a claim after too much epoch, the maximum number of epochs that can be claimed with one invokation is limited by the `MAX_NUMBER_OF_EPOCH` constant, in the template contract set to 100.