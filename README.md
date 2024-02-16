# EON

Horizen EON is a public proof-of-stake sidechain and a fully EVM-compatible smart contracting platform that allows developers to efficiently build and deploy dapps on Horizen, while fully benefiting from the Ethereum ecosystem.

[Public Release Notes](/doc/index.md)

[Changelog](/CHANGELOG.md)

### EVM compatibility
Current EVM implementation is based on go-ethereum [Archanes](https://github.com/ethereum/go-ethereum/releases/tag/v1.10.26) (`v1.13.4`).<br>
Solidity compiler is supported up to version `0.8.23`.

### Supported platforms

EON node is available on Linux and Windows (64bit).

### Documentation

More information of how to connect wallets, write smart contracts, run a local node and interact with EON is available [here]( https://eon.horizen.io/docs/).

### Project structure
- node: <br>
  the module contains everything you need to run an EON node;
 
- bootstraptool: <br>
  the module contains the tools you need if you intend to register a new sidechain and create the configuration file for it
  <br>
  Usage:<br>
    - obtain the jar by running <b>mvn package [-Ppregobi] [-Pgobi]</b> <br>
      NOTE: The -Ppregobi OR -Pgobi suffix is needed ONLY to build a bootstrapping tool for Pregobi/Gobi testnet network.
      They differentiate from the default one for not applying the fee fork parameters (GasBLock limit 10ML, basefee 20 gwei) from
      the genesys block.    
    - launch the bootstrapping tool by running: <b>java -jar < jarname ></b>
    - There is more convenient way of using the bootstrap tool using a docker container. The bootstrap tool docker image 
      is built and published to `zencash/evmapp-bootstraptool:[:tag]`. 
      A helper script is provided in ci/devtools: [evmapp-bootstraptool](ci/devtools/bootstrap_tool.sh). This script can 
      be run in this way: `./ci/devtools/bootstrap_tool.sh help` and can be used to generate the required keys for forger 
      nodes and for signer nodes. 

  

