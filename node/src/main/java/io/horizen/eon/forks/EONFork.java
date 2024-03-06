package io.horizen.eon.forks;

import io.horizen.eon.ApplicationConstants;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.util.List;
import java.util.Optional;

public abstract class EONFork {

    protected Optional<String> sidechainId;

    protected abstract int getActivationRegtest();
    protected abstract int getActivationTestnetPregobi();
    protected abstract int getActivationTestnetGobi();
    protected abstract int getActivationTestnet();
    protected abstract int getActivationMainnet();

    public EONFork(Optional<String> sidechainId){
        this.sidechainId = sidechainId;
    }

    public abstract List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>>  getPairs();

    protected int getActivationTestnet(Optional<String> sidechainId){
        if (sidechainId.isPresent()){
            switch (sidechainId.get()){
                case ApplicationConstants.PREGOBI_SIDECHAINID:
                    //Pre-Gobi (parallel testnet) fork configuration
                    return getActivationTestnetPregobi();
                case ApplicationConstants.GOBI_SIDECHAINID:
                    //Gobi (official testnet) fork configuration
                    return getActivationTestnetGobi();
                default:
                    //any other testnet
                    return getActivationTestnet();
            }
        } else {
            return getActivationTestnet();
        }
    }



}
