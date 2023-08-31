package io.horizen.eon;

import io.horizen.account.fork.GasFeeFork;
import io.horizen.account.fork.ZenDAOFork;
import io.horizen.fork.ForkConfigurator;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.math.BigInteger;
import java.util.List;
import java.util.Optional;

public class EonForkConfigurator extends ForkConfigurator {

    static final int FEE_REGTEST_FORKPOINT = 7;
    static final int FEE_PREGOBI_TESTNET_FORKPOINT = 718;
    static final int FEE_GOBI_TESTNET_FORKPOINT = 624;
    static final int FEE_TESTNET_FORKPOINT = 0;
    static final int FEE_MAINNET_FORKPOINT = 0;

    static final int ZENDAO_REGTEST_FORKPOINT = 7;
    static final int ZENDAO_TESTNET_FORKPOINT = 800;
    static final int ZENDAO_MAINNET_FORKPOINT = 7;

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

        optionalSidechainForks = List.of(
                new Pair<>(new SidechainForkConsensusEpoch(
                        FEE_REGTEST_FORKPOINT,
                        getFeeForkTestnetActivation(sidechainId),
                        FEE_MAINNET_FORKPOINT),
                        feeFork1Params),

                new Pair<>(new SidechainForkConsensusEpoch(
                        ZENDAO_REGTEST_FORKPOINT,
                        getZenDAOTestnetActivation(sidechainId),
                        ZENDAO_MAINNET_FORKPOINT),
                        zenDAOFork)
        );
        mandatorySidechainFork1 = new SidechainForkConsensusEpoch(0, 0, 0);
    }

    private int getFeeForkTestnetActivation(Optional<String> sidechainId){
        if (sidechainId.isPresent()){
            switch (sidechainId.get()){
                case ApplicationConstants.PREGOBI_SIDECHAINID:
                    //Pre-Gobi (parallel testnet) fork configuration
                    return FEE_PREGOBI_TESTNET_FORKPOINT;
                case ApplicationConstants.GOBI_SIDECHAINID:
                    //Gobi (official testnet) fork configuration
                    return FEE_GOBI_TESTNET_FORKPOINT;
                default:
                    //any other testnet
                    return FEE_TESTNET_FORKPOINT;
            }
        }else{
            return 0;
        }
    }

    private int getZenDAOTestnetActivation(Optional<String> sidechainId){
        if (sidechainId.isPresent()){
            switch (sidechainId.get()){
                // TODO: handle any specific sidechain if any. For the time being there is only one possibility
                default:
                    //any other testnet
                    return ZENDAO_TESTNET_FORKPOINT;
            }
        } else {
            return ZENDAO_TESTNET_FORKPOINT;
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
