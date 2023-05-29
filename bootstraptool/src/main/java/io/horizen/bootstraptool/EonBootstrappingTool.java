package io.horizen.bootstraptool;

import io.horizen.AbstractScBootstrappingTool;
import io.horizen.AccountModel;
import io.horizen.ScBootstrappingToolCommandProcessor;
import io.horizen.tools.utils.ConsolePrinter;

public final class EonBootstrappingTool extends AbstractScBootstrappingTool {
    public EonBootstrappingTool() {
        super(new ConsolePrinter());
    }

    public static void main(String[] args) {
        AbstractScBootstrappingTool bootstrap = new EonBootstrappingTool();
        bootstrap.startCommandTool(args);
    }

    @Override
    protected ScBootstrappingToolCommandProcessor getBootstrappingToolCommandProcessor() {
        return new ScBootstrappingToolCommandProcessor(printer, new AccountModel());
    }
}
