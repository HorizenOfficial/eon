package io.horizen.eon.forks;

import io.horizen.account.fork.Version1_3_0Fork;
import io.horizen.account.fork.Version1_4_0Fork;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.util.List;
import java.util.Optional;

/**
 * EON fork 6 (introduced in Version 1.4.0)
 * New on-chain delegated staking reward mechanism, new handling of rewards from mainchain
 */
public class F6Fork extends EONFork {
    public F6Fork(Optional<String> sidechainId) {
        super(sidechainId);
    }

    @Override
    protected int getActivationRegtest() {
        return 7;
    }
    @Override
    protected int getActivationTestnetPregobi() {return 2172;} //estimated start at  FRI 17 May 2024 12:31 Milano time

    @Override
    protected int getActivationTestnetGobi() {
        return 10000000;  //TBD
    }
    @Override
    protected int getActivationTestnet() { return 2101; //not used
    }
    @Override
    protected int getActivationMainnet() {
        return  10000000;  //TBD
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getPairs() {
        return  List.of(
                new Pair<>(
                        new SidechainForkConsensusEpoch(
                                getActivationRegtest(),
                                getActivationTestnet(sidechainId),
                                getActivationMainnet()),
                        new Version1_4_0Fork(true)
                )
        );
    }
}