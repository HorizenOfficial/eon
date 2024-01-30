package io.horizen.eon.forks;

import io.horizen.account.fork.ContractInteroperabilityFork;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.util.List;
import java.util.Optional;

/**
 * EON fork 3: Native <> Real smart contract interoperability
 */
public class F3Fork extends EONFork {


    public F3Fork(Optional<String> sidechainId) {
        super(sidechainId);
    }

    @Override
    protected int getActivationRegtest() {
        return 7;
    }
    @Override
    protected int getActivationTestnetPregobi() {
        return 1815; //estimated start: Mon 13 Nov 2023 13:01 Milano time
    }
    @Override
    protected int getActivationTestnetGobi() {
        return 1900; //estimated  start; Tue 28 Nov 11 2023 15:21 Milano time
    }
    @Override
    protected int getActivationTestnet() { return 1900;  //not used
    }
    @Override
    protected int getActivationMainnet() {
        return  1213;   //estimated  start; Tue 12 Dec 2023 18:55 Milano time
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getPairs() {
        return  List.of(
                new Pair<>(
                        new SidechainForkConsensusEpoch(
                                getActivationRegtest(),
                                getActivationTestnet(sidechainId),
                                getActivationMainnet()),
                        new ContractInteroperabilityFork(true)
                )
        );
    }
}