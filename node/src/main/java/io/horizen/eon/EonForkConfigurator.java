package io.horizen.eon;

import io.horizen.account.fork.ContractInteroperabilityFork;
import io.horizen.account.fork.GasFeeFork;
import io.horizen.account.fork.ZenDAOFork;
import io.horizen.fork.*;
import io.horizen.utils.Pair;

import java.math.BigInteger;
import java.util.List;
import java.util.Optional;

public class EonForkConfigurator extends ForkConfigurator {

    //EON fork 1: change of fee params
    static final int F1_REGTEST_FORKPOINT = 7;
    static final int F1_PREGOBI_TESTNET_FORKPOINT = 718;
    static final int F1_GOBI_TESTNET_FORKPOINT = 624;
    static final int F1_TESTNET_FORKPOINT = 0;
    static final int F1_MAINNET_FORKPOINT = 0;

    //EON fork 2: ZenDAO + Change of consensus params + change of active slot coefficient
    static final int F2_REGTEST_FORKPOINT = 7;
    static final int F2_PREGOBI_TESTNET_FORKPOINT = 1698; //estimated start: Wed 13 Sept 2023 15:31 Milano time
    static final int F2_GOBI_TESTNET_FORKPOINT = 1804; ///estimated start: Mon 09 Oct 2023 16:21 Milano time
    static final int F2_TESTNET_FORKPOINT = 800;
    static final int F2_MAINNET_FORKPOINT = 1109;  ///estimated start: Thu 19 Oct 2023 15:55 Milano time

    //EON fork 3: Native <> Real smart contract interoperability
    static final int F3_REGTEST_FORKPOINT = 7;
    static final int F3_PREGOBI_TESTNET_FORKPOINT = 1815; //estimated start: Mon 13 Nov 2023 13:01 Milano time
    static final int F3_GOBI_TESTNET_FORKPOINT = 500000000; ///TODO: to be estimated
    static final int F3_TESTNET_FORKPOINT = 500000000; //not used
    static final int F3_MAINNET_FORKPOINT = 500000000;  ///TODO: to be estimated




    private final SidechainForkConsensusEpoch mandatorySidechainFork1;
    private final List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> optionalSidechainForks;

    public EonForkConfigurator(Optional<String> sidechainId) {
        // block gas limit: 10 million
        // minimum base fee: 20 Gwei (20*10^9)
        GasFeeFork feeFork1Params = new GasFeeFork(
                // block gas limit: 10 million
                BigInteger.valueOf(10000000),
                BigInteger.valueOf(2),
                BigInteger.valueOf(8),
                // minimum base fee: 20 Gwei (20*10^9)
                BigInteger.valueOf(20000000000L)
        );

        ZenDAOFork zenDAOFork = new ZenDAOFork(true);

        ConsensusParamsFork consensusParamsFork = new ConsensusParamsFork(15000, 3);

        ActiveSlotCoefficientFork activeSlotCoefficientFork = new ActiveSlotCoefficientFork(0.167);


        optionalSidechainForks = List.of(
                new Pair<>(new SidechainForkConsensusEpoch(
                        F1_REGTEST_FORKPOINT,
                        getFeeForkTestnetActivation(sidechainId),
                        F1_MAINNET_FORKPOINT),
                        feeFork1Params),

                new Pair<>(new SidechainForkConsensusEpoch(
                        F2_REGTEST_FORKPOINT,
                        getFork2TestnetActivation(sidechainId),
                        F2_MAINNET_FORKPOINT),
                        zenDAOFork),

                new Pair<>(new SidechainForkConsensusEpoch(
                        F2_REGTEST_FORKPOINT,
                        getFork2TestnetActivation(sidechainId),
                        F2_MAINNET_FORKPOINT),
                        consensusParamsFork),

                new Pair<>(new SidechainForkConsensusEpoch(
                        F2_REGTEST_FORKPOINT,
                        getFork2TestnetActivation(sidechainId),
                        F2_MAINNET_FORKPOINT),
                        activeSlotCoefficientFork),

                new Pair<>(
                          new SidechainForkConsensusEpoch(
                        F3_REGTEST_FORKPOINT,
                        getFork3TestnetActivation(sidechainId),
                        F3_MAINNET_FORKPOINT),
                        new ContractInteroperabilityFork(true)
                )

        );
        mandatorySidechainFork1 = new SidechainForkConsensusEpoch(0, 0, 0);
    }

    private int getFeeForkTestnetActivation(Optional<String> sidechainId){
        if (sidechainId.isPresent()){
            switch (sidechainId.get()){
                case ApplicationConstants.PREGOBI_SIDECHAINID:
                    //Pre-Gobi (parallel testnet) fork configuration
                    return F1_PREGOBI_TESTNET_FORKPOINT;
                case ApplicationConstants.GOBI_SIDECHAINID:
                    //Gobi (official testnet) fork configuration
                    return F1_GOBI_TESTNET_FORKPOINT;
                default:
                    //any other testnet
                    return F1_TESTNET_FORKPOINT;
            }
        }else{
            return F1_TESTNET_FORKPOINT;
        }
    }

    private int getFork2TestnetActivation(Optional<String> sidechainId){
        if (sidechainId.isPresent()){
            switch (sidechainId.get()){
                case ApplicationConstants.PREGOBI_SIDECHAINID:
                    //Pre-Gobi (parallel testnet) fork configuration
                    return F2_PREGOBI_TESTNET_FORKPOINT;
                case ApplicationConstants.GOBI_SIDECHAINID:
                    //Gobi (official testnet) fork configuration
                    return F2_GOBI_TESTNET_FORKPOINT;
                default:
                    //any other testnet
                    return F2_TESTNET_FORKPOINT;
            }
        } else {
            return F2_TESTNET_FORKPOINT;
        }
    }

    private int getFork3TestnetActivation(Optional<String> sidechainId){
        if (sidechainId.isPresent()){
            switch (sidechainId.get()){
                case ApplicationConstants.PREGOBI_SIDECHAINID:
                    //Pre-Gobi (parallel testnet) fork configuration
                    return F3_PREGOBI_TESTNET_FORKPOINT;
                case ApplicationConstants.GOBI_SIDECHAINID:
                    //Gobi (official testnet) fork configuration
                    return F3_GOBI_TESTNET_FORKPOINT;
                default:
                    //any other testnet
                    return F3_TESTNET_FORKPOINT;
            }
        } else {
            return F3_TESTNET_FORKPOINT;
        }
    }

    @Override
    public SidechainForkConsensusEpoch fork1activation() {
        return mandatorySidechainFork1;
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getOptionalSidechainForks() {
        return optionalSidechainForks;
    }
}
