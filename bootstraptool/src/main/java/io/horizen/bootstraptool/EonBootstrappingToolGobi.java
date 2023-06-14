package io.horizen.bootstraptool;

import io.horizen.eon.ApplicationConstants;

import java.util.Optional;

/**
 * Alternative bootstrapping tool entry point, to be used only for GOBI testnet
 * Will apply fee fork parameters (Gas Limit 10ML, baseFee 20gwei) only from GOBI consensus epoch set on EonForkConfigurator
 */
public final class EonBootstrappingToolGobi extends EonBootstrappingTool {

    public static void main(String[] args) {
        EonBootstrappingToolGobi bootstrap = new EonBootstrappingToolGobi();
        bootstrap.startCommandTool(args);
    }

    @Override
    protected Optional<String> sidechainId() {
        return Optional.of(ApplicationConstants.GOBI_SIDECHAINID);
    }
}
