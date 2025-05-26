package io.horizen.eon.forks;

import io.horizen.account.fork.Version1_5_0Fork;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.util.List;
import java.util.Optional;

/**
 * EON fork 7 (introduced in Version 1.5.0)
 * Disables the backward transfers submission as part of the strategy which stops any cross-chain transfer operation between Mainchain and Sidechain with a view to EON2 migration.
 */
public class F7Fork extends EONFork {
    public F7Fork(Optional<String> sidechainId) {
        super(sidechainId);
    }

    @Override
    protected int getActivationRegtest() {
        return 7;
    }
    @Override
    protected int getActivationTestnetPregobi() {
        return 2892; // Tue, 27 May 2025 10:31:00 GMT
    }

    @Override
    protected int getActivationTestnetGobi() {
        return 2985;  //Sun, 15 Jun 2025 16:51:00 GMT
    }
    @Override
    protected int getActivationTestnet() { return 10000000; //not used
    }
    @Override
    protected int getActivationMainnet() {
        return  2342;  // Tue, 22 Jul 2025 18:25:00 GMT
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getPairs() {
        return  List.of(
                new Pair<>(
                        new SidechainForkConsensusEpoch(
                                getActivationRegtest(),
                                getActivationTestnet(sidechainId),
                                getActivationMainnet()),
                        new Version1_5_0Fork(true)
                )
        );
    }
}
