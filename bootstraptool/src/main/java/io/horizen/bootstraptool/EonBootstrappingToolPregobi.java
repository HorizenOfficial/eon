package io.horizen.bootstraptool;

/**
 * Alternative bootstrapping tool entry point, to be used only for PREGOBI testnet
 */
public final class EonBootstrappingToolPregobi  extends EonBootstrappingTool {

    public static void main(String[] args) {
        EonBootstrappingToolPregobi bootstrap = new EonBootstrappingToolPregobi();
        bootstrap.startCommandTool(args);
    }

    @Override
    protected boolean isPreGobiVersion(){
        return true;
    }

}
