package io.horizen.eon.forks;

import io.horizen.account.fork.Version1_3_0Fork;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;
import java.util.List;
import java.util.Optional;

/**
 * EON fork 5 (introduced in Version 1.3.0)
 * EVM update to Shanghai, Updates to native stake smart contract, Pause forging
 */
public class F5Fork extends EONFork {
    public F5Fork(Optional<String> sidechainId) {
        super(sidechainId);
    }

    @Override
    protected int getActivationRegtest() {
        return 7;
    }
    @Override
    protected int getActivationTestnetPregobi() {return 2007;} //estimated start at WED 21 Feb 2024 13:01 Milano time

    @Override
    protected int getActivationTestnetGobi() {
        return 2101;  //estimated start at TUE 12 March 2024 07:51 Milano time
    }
    @Override
    protected int getActivationTestnet() { return 2101; //not used
    }
    @Override
    protected int getActivationMainnet() {
        return  1405; //estimated start at THU 21 March 2024 18:55 Milano time
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getPairs() {
        return  List.of(
                new Pair<>(
                        new SidechainForkConsensusEpoch(
                                getActivationRegtest(),
                                getActivationTestnet(sidechainId),
                                getActivationMainnet()),
                        new Version1_3_0Fork(true)
                )
        );
    }
}