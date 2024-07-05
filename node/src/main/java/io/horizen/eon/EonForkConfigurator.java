package io.horizen.eon;

import io.horizen.eon.forks.*;
import io.horizen.fork.*;
import io.horizen.utils.Pair;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class EonForkConfigurator extends ForkConfigurator {

    private final SidechainForkConsensusEpoch mandatorySidechainFork1;
    private final List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> optionalSidechainForks;

    public EonForkConfigurator(Optional<String> sidechainId) {
        optionalSidechainForks = new ArrayList<>();
        optionalSidechainForks.addAll(new F1Fork(sidechainId).getPairs());
        optionalSidechainForks.addAll(new F2Fork(sidechainId).getPairs());
        optionalSidechainForks.addAll(new F3Fork(sidechainId).getPairs());
        optionalSidechainForks.addAll(new F4Fork(sidechainId).getPairs());
        optionalSidechainForks.addAll(new F5Fork(sidechainId).getPairs());
        optionalSidechainForks.addAll(new F6Fork(sidechainId).getPairs());
        optionalSidechainForks.addAll(new F7Fork(sidechainId).getPairs());
        mandatorySidechainFork1 = new SidechainForkConsensusEpoch(0, 0, 0);
    }

    @Override
    public SidechainForkConsensusEpoch forkActivation() {
        return mandatorySidechainFork1;
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getOptionalSidechainForks() {
        return optionalSidechainForks;
    }
}