# EON

Horizen EON is a public proof-of-stake sidechain and a fully EVM-compatible smart contracting platform that allows developers to efficiently build and deploy dapps on Horizen, while fully benefiting from the Ethereum ecosystem.

### Supported platforms

EON node is available on Linux and Windows (64bit).

### Documentation

More information of how to connect wallets, write smart contracts and interact with EON is available [here]( https://eon.horizen.io/docs/).

### Project structure
- node: <br>
  the module contains everything you need to run an EON node;
 
- bootstraptool: <br>
  the module contains the tools you need in order to register and create the configuration file for the EON sidechain.<br>
  Usage:<br>
    - obtain the jar by running <b>mvn package [-Ppregobi] [-Pgobi]</b> <br>
      NOTE: The -Ppregobi OR -Pgobi suffix is needed ONLY to build a bootstrapping tool for Pregobi/Gobi testnet network.
      They differentiate from the default one for not applying the fee fork parameters (GasBLock limit 10ML, basefee 20 gwei) from
      the genesys block.    
    - launch the bootstrapping tool by running: <b>java -jar < jarname ></b>

  

