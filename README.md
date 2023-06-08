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
    - obtain the jar by running <b>mvn package [-Dpregobi] </b> <br>
      NOTE: The -Dpregobi suffix is needed ONLY to build a bootstrapping tool for Pregobi testnet network.     
    - launch the bootstrapping tool by running: <b>java -jar < jarname ></b>

  

