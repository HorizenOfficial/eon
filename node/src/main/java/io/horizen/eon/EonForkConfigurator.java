package io.horizen.eon;

import io.horizen.fork.ForkConfigurator;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.util.ArrayList;
import java.util.List;

public class EonForkConfigurator extends ForkConfigurator {
    @Override
    public SidechainForkConsensusEpoch fork1activation() {
        return new SidechainForkConsensusEpoch(0, 0, 0);
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getOptionalSidechainForks() {
        return new ArrayList<>();
        // note: the default values for GasFeeFork are automatically enabled on epoch 0
//        return List.of(
//                new Pair<>(
//                        new SidechainForkConsensusEpoch(15, 15, 15),
//                        new GasFeeFork(
//                                BigInteger.valueOf(25000000),
//                                BigInteger.valueOf(2),
//                                BigInteger.valueOf(8),
//                                BigInteger.ZERO
//                        )
//                )
//        );
    }
}
