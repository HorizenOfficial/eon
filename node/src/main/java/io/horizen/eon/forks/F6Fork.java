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
    protected int getActivationTestnetPregobi() {return 2180;} //estimated start at  TUE 21 May 2024 16:31 Milano time

    @Override
    protected int getActivationTestnetGobi() {
        return 2274;  //estimated starts at MON 10 June 2024 11:21 Milano time
    }
    @Override
    protected int getActivationTestnet() { return 2274; //not used
    }
    @Override
    protected int getActivationMainnet() {
        return  1593;  //estimated starts at THU 27 June 2024 17:55 Milano time
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
