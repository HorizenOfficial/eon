# Changelog
## 1.4.0
* SDK dependency updated to version 0.12.0 (see [SDK changelog](https://github.com/HorizenOfficial/Sidechains-SDK/blob/0.12.0/CHANGELOG.md))
* Fork configuration to enable new on-chain delegated staking reward mechanism and new handling of rewards from mainchain
* Added support for metrics endpoint
* Bug fix: Modify entrypoint.sh: Improve declared ip detection in MacOS environments

## 1.3.1
* Bug fix: Modify entrypoint.sh: Allow all node types to set FORGER_MAXCONNECTIONS env variable

## 1.3.0
* SDK dependency updated to version 0.11.0 (see [SDK changelog](https://github.com/HorizenOfficial/Sidechains-SDK/blob/0.11.0/CHANGELOG.md))
* Fork configuration to enable: EVM Update, Forger stake native smart contract new methods, Pause Forging feature

## 1.2.1
* SDK dependency updated to version 0.10.1 (see [SDK changelog](https://github.com/HorizenOfficial/Sidechains-SDK/blob/0.10.1/CHANGELOG.md))

## 1.2.0
* SDK dependency updated to version 0.10.0 (see [SDK changelog](https://github.com/HorizenOfficial/Sidechains-SDK/blob/0.10.0/CHANGELOG.md))
* Fork configuration to enable new functionalities (ZenIP 42203/42206 support, ZenDao Multisig support)

## 1.1.0
* SDK dependency updated to version 0.9.0 (see [SDK changelog](https://github.com/HorizenOfficial/Sidechains-SDK/blob/0.9.0/CHANGELOG.md))
* Fork configuration to enable Native<>Real smart contract interoperability
* Added endpoints documentation

## 1.0.1
* SDK dependency updated to version 0.8.1

## 1.0.1
* SDK dependency updated to version 0.8.1

## 1.0.0
* SDK dependency updated to version 0.8.0
* Fork configuration to enable decentralized governance (ZenDao) and change consensus parameters (consensus epoch slot time and length, active slot coefficient)
* Introduced a delay of 6 blocks in the inclusion of the mainchain blocks

## 0.2.1
* Updated SDK dependency to 0.7.2

## 0.2.0-1
* Updated entrypoint script logic
* Updated CI/CD 
* Minor fixes

## 0.2.0
* Updated SDK dependency to 0.7.1

## 0.1.0
Initial version of the EON application.
* Based on top of [Sidechains-SDK](https://github.com/HorizenOfficial/Sidechains-SDK) version 0.7.0
* EVM support
* Fee parameters set to 10 million gas fee per block, 20 gwei of minimum baseFee
