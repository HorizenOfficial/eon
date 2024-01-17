package io.horizen.eon.forks;

import io.horizen.account.fork.ContractInteroperabilityFork;
import io.horizen.account.fork.Version1_2_0Fork;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.util.List;
import java.util.Optional;

/**
 * EON fork 4 (introduced in Version 1.2.0)
 * ZenIP 42203/42206, ZenDao Multisig
 */
public class F4Fork extends EONFork {
    public F4Fork(Optional<String> sidechainId) {
        super(sidechainId);
    }

    @Override
    protected int getActivationRegtest() {
        return 7;
    }
    @Override
    protected int getActivationTestnetPregobi() {
        return 1875; //estimated start: Thu 14 Dec 2023 19:01 Milano time
    }
    @Override
    protected int getActivationTestnetGobi() {
        return 1982;  //estimated start: Wed  10 Jan 2024 08:21 Milano time
    }
    @Override
    protected int getActivationTestnet() { return 1982;  //not used
    }
    @Override
    protected int getActivationMainnet() {
        return  1297; //estimated start: Thu 25 Jan 2024 12:55 Milano Time
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getPairs() {
        return  List.of(
                new Pair<>(
                        new SidechainForkConsensusEpoch(
                                getActivationRegtest(),
                                getActivationTestnet(sidechainId),
                                getActivationMainnet()),
                        new Version1_2_0Fork(true)
                )
        );
    }
}