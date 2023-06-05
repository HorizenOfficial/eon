package io.horizen.eon;

import io.horizen.account.fork.GasFeeFork;
import io.horizen.fork.ForkConfigurator;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class EonForkConfigurator extends ForkConfigurator {

    private Boolean pregobiSidechain;

    public EonForkConfigurator(Boolean isPregobiSidechain) {
        pregobiSidechain = isPregobiSidechain;
    }

    @Override
    public SidechainForkConsensusEpoch fork1activation() {
        return new SidechainForkConsensusEpoch(0, 0, 0);
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getOptionalSidechainForks() {
        if (pregobiSidechain) {
            //Pre-GObi (parallel testnet) fork configuration
            return List.of(
                    new Pair<>(
                            new SidechainForkConsensusEpoch(0, 718, 0),
                            new GasFeeFork(
                                    // block gas limit: 10 million
                                    BigInteger.valueOf(10000000),
                                    BigInteger.valueOf(2),
                                    BigInteger.valueOf(8),
                                    // minimum base fee: 20 Gwei (20*10^9)
                                    BigInteger.valueOf(20000000000L)
                            )
                    )
            );
        } else {
            //TODO: add official gobi testnet fork configuration
            return new ArrayList<>();
        }
    }
}
