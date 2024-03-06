package io.horizen.eon.forks;

import io.horizen.account.fork.GasFeeFork;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;
import java.math.BigInteger;
import java.util.List;
import java.util.Optional;

/**
EON fork 1: change of fee params
 */
public class F1Fork extends EONFork {

    // block gas limit: 10 million
    // minimum base fee: 20 Gwei (20*10^9)
    private GasFeeFork feeFork1Params = new GasFeeFork(
            // block gas limit: 10 million
            BigInteger.valueOf(10000000),
            BigInteger.valueOf(2),
            BigInteger.valueOf(8),
            // minimum base fee: 20 Gwei (20*10^9)
            BigInteger.valueOf(20000000000L)
    );

    @Override
    protected int getActivationRegtest() {
        return 7;
    }
    @Override
    protected int getActivationTestnetPregobi() {
        return 718;
    }
    @Override
    protected int getActivationTestnetGobi() {
        return 624;
    }
    @Override
    protected int getActivationTestnet() {
        return 0;
    }
    @Override
    protected int getActivationMainnet() {
        return 0;
    }

    public F1Fork(Optional<String> sidechainId) {
        super(sidechainId);
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getPairs() {
        return List.of(
                new Pair<>(new SidechainForkConsensusEpoch(
                        getActivationRegtest(),
                        getActivationTestnet(sidechainId),
                        getActivationMainnet()),
                        feeFork1Params)
        );
    }
}
