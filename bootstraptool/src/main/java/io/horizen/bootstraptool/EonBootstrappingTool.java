package io.horizen.bootstraptool;

import io.horizen.AbstractScBootstrappingTool;
import io.horizen.ScBootstrappingToolCommandProcessor;
import io.horizen.eon.ApplicationConstants;
import io.horizen.tools.utils.ConsolePrinter;

import java.util.Optional;

/**
 * Default EON Boostrapping tool entry point.
 * To be used for any new  mainnet testnet or regtest enviroment.
 * Will apply fee fork parameters (Gas Limit 10ML, baseFee 20gwei) from block 0 (genesis)
 */
public class EonBootstrappingTool extends AbstractScBootstrappingTool {

    public EonBootstrappingTool() {
        super(new ConsolePrinter());
    }

    public static void main(String[] args) {
        EonBootstrappingTool bootstrap = new EonBootstrappingTool();
        bootstrap.startCommandTool(args);
    }

    @Override
    public void startCommandTool(String[] args) {
        System.out.println("Starting EON bootstrapping tool " + printVersion());
        super.startCommandTool(args);
    }

    @Override
    protected ScBootstrappingToolCommandProcessor getBootstrappingToolCommandProcessor() {
        return new ScBootstrappingToolCommandProcessor(printer, new EonModel(sidechainId()));
    }

    protected Optional<String> sidechainId(){
        return Optional.empty();
    }

    private String printVersion(){
        if (sidechainId().isPresent()){
            switch (sidechainId().get()){
                case ApplicationConstants.PREGOBI_SIDECHAINID:
                    return "PREGOBI version";
                case ApplicationConstants.GOBI_SIDECHAINID:
                    return "GOBI version";
                default:
                    return "";
            }
        }else{
            return "";
        }
    }

}
