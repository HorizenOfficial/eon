package io.horizen.eon;

import io.horizen.account.fork.GasFeeFork;
import io.horizen.fork.ForkConfigurator;
import io.horizen.fork.OptionalSidechainFork;
import io.horizen.fork.SidechainForkConsensusEpoch;
import io.horizen.utils.Pair;

import java.math.BigInteger;
import java.util.List;
import java.util.Optional;

public class EonForkConfigurator extends ForkConfigurator {


    private final SidechainForkConsensusEpoch mandatorySidechainFork1;
    private final List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> optionalSidechainForks;

    private final GasFeeFork feeFork1Params =  new GasFeeFork(
            // block gas limit: 10 million
            BigInteger.valueOf(10000000),
            BigInteger.valueOf(2),
            BigInteger.valueOf(8),
            // minimum base fee: 20 Gwei (20*10^9)
            BigInteger.valueOf(20000000000L)
    );

    public EonForkConfigurator(Optional<String> sidechainId) {
        optionalSidechainForks=  List.of(
                new Pair<>(new SidechainForkConsensusEpoch(0, getFeeForkTestentActivation(sidechainId), 0), feeFork1Params)
        );
        mandatorySidechainFork1 = new SidechainForkConsensusEpoch(0, 0, 0);
    }

    private int getFeeForkTestentActivation(Optional<String> sidechainId){
        if (sidechainId.isPresent()){
            switch (sidechainId.get()){
                case ApplicationConstants.PREGOBI_SIDECHAINID:
                    //Pre-Gobi (parallel testnet) fork configuration
                    return 718;
                case ApplicationConstants.GOBI_SIDECHAINID:
                    //Gobi (official testnet) fork configuration
                    return 624;
                default:
                    //any other testnet
                    return 0;
            }
        }else{
            return 0;
        }
    }

    @Override
    public SidechainForkConsensusEpoch fork1activation() {
        return mandatorySidechainFork1;
    }

    @Override
    public List<Pair<SidechainForkConsensusEpoch, OptionalSidechainFork>> getOptionalSidechainForks() {
        return optionalSidechainForks;
    }
}
