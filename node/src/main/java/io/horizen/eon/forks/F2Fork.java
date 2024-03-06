package io.horizen.eon.forks;

import io.horizen.account.fork.ZenDAOFork;
import io.horizen.fork.ActiveSlotCoefficientFork;
import io.horizen.fork.ConsensusParamsFork;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;
import java.util.List;
import java.util.Optional;

/**
 * EON fork 2: ZenDAO + Change of consensus params + change of active slot coefficient
 */
public class F2Fork extends EONFork {

    private ZenDAOFork zenDAOFork = new ZenDAOFork(true);
    private ConsensusParamsFork consensusParamsFork = new ConsensusParamsFork(15000, 3);
    private ActiveSlotCoefficientFork activeSlotCoefficientFork = new ActiveSlotCoefficientFork(0.167);

    public F2Fork(Optional<String> sidechainId) {
        super(sidechainId);
    }

    @Override
    protected int getActivationRegtest() {
        return 7;
    }
    @Override
    protected int getActivationTestnetPregobi() {
        return 1698; //estimated start: Wed 13 Sept 2023 15:31 Milano time
    }
    @Override
    protected int getActivationTestnetGobi() {
        return 1804; ///estimated start: Mon 09 Oct 2023 16:21 Milano time
    }
    @Override
    protected int getActivationTestnet() {
        return 800;
    }
    @Override
    protected int getActivationMainnet() {
        return 1109;  ///estimated start: Thu 19 Oct 2023 15:55 Milano time
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getPairs() {
        return  List.of(
                new Pair<>(new SidechainForkConsensusEpoch(
                        getActivationRegtest(),
                        getActivationTestnet(sidechainId),
                        getActivationMainnet()),
                        zenDAOFork),

                new Pair<>(new SidechainForkConsensusEpoch(
                        getActivationRegtest(),
                        getActivationTestnet(sidechainId),
                        getActivationMainnet()),
                        consensusParamsFork),

                new Pair<>(new SidechainForkConsensusEpoch(
                        getActivationRegtest(),
                        getActivationTestnet(sidechainId),
                        getActivationMainnet()),
                        activeSlotCoefficientFork)
                );
    }
}