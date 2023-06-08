package io.horizen.bootstraptool;
import io.horizen.AbstractScBootstrappingTool;
import io.horizen.ScBootstrappingToolCommandProcessor;
import io.horizen.tools.utils.ConsolePrinter;

/**
 * Alternative bootstrapping tool entry point, to be used only for PREGOBI testnet
 */
public final class EonBootstrappingToolPregobi  extends AbstractScBootstrappingTool {

    public EonBootstrappingToolPregobi() {
        super(new ConsolePrinter());
    }

    public static void main(String[] args) {
        EonBootstrappingToolPregobi bootstrap = new EonBootstrappingToolPregobi();
        System.out.println("Starting EON bootstrapping tool - PREGOBI version!");
        bootstrap.startCommandTool(args);
    }

    @Override
    protected ScBootstrappingToolCommandProcessor getBootstrappingToolCommandProcessor() {
        return new ScBootstrappingToolCommandProcessor(printer, new EonModel(true));
    }

}
