package io.horizen.bootstraptool;

import io.horizen.AbstractAccountModel;
import io.horizen.account.state.EvmMessageProcessor;
import io.horizen.account.state.MessageProcessor;
import io.horizen.eon.EonForkConfigurator;
import io.horizen.fork.ForkConfigurator;
import io.horizen.params.NetworkParams;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Boostrapping tool model for EON sidechain
 */
public class EonModel extends AbstractAccountModel {

    private Optional<String> sidechainId;

    public EonModel(Optional<String> sidechainId){
        this.sidechainId = sidechainId;
    }

    @Override
    protected List<MessageProcessor> getCustomMessageProcessors(NetworkParams params) {
        List<MessageProcessor> customMessageProcessors = new ArrayList<>();
        customMessageProcessors.add(new EvmMessageProcessor());
        return customMessageProcessors;
    }

    @Override
    public ForkConfigurator getForkConfigurator() {
        return new EonForkConfigurator(sidechainId);
    }
}
