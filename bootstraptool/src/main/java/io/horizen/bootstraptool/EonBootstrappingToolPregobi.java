package io.horizen.bootstraptool;

import io.horizen.eon.ApplicationConstants;

import java.util.Optional;

/**
 * Alternative bootstrapping tool entry point, to be used only for PREGOBI testnet
 * Will apply fee fork parameters (Gas Limit 10ML, baseFee 20gwei) only from PREGOBI consensus epoch set on EonForkConfigurator
 */
public final class EonBootstrappingToolPregobi  extends EonBootstrappingTool {

    public static void main(String[] args) {
        EonBootstrappingToolPregobi bootstrap = new EonBootstrappingToolPregobi();
        bootstrap.startCommandTool(args);
    }

    @Override
    protected Optional<String> sidechainId() {
        return Optional.of(ApplicationConstants.PREGOBI_SIDECHAINID);
    }
}
