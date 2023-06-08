package io.horizen.bootstraptool;

import io.horizen.AbstractScBootstrappingTool;
import io.horizen.ScBootstrappingToolCommandProcessor;
import io.horizen.tools.utils.ConsolePrinter;

/**
 * Default EON Boostrapping tool entry point.
 * To be used for official mainnet/testnet or regtest enviroments
 */
public class EonBootstrappingTool extends AbstractScBootstrappingTool {


    public EonBootstrappingTool() {
        super(new ConsolePrinter());
    }

    public static void main(String[] args) {
        EonBootstrappingTool bootstrap = new EonBootstrappingTool();
        System.out.println("Starting EON bootstrapping tool");
        bootstrap.startCommandTool(args);
    }

    @Override
    protected ScBootstrappingToolCommandProcessor getBootstrappingToolCommandProcessor() {
        return new ScBootstrappingToolCommandProcessor(printer, new EonModel(false));
    }

}
