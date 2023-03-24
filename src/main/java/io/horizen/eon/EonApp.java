package io.horizen.eon;

import com.google.inject.Guice;
import com.google.inject.Injector;
import io.horizen.account.AccountSidechainApp;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;

public class EonApp {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Please provide settings file name as first parameter!");
            return;
        }

        if (!new File(args[0]).exists()) {
            System.out.println("File on path " + args[0] + " doesn't exist");
            return;
        }
        String settingsFileName = args[0];

        Injector injector = Guice.createInjector(new EonAppModule(settingsFileName));
        AccountSidechainApp sidechainApp = injector.getInstance(AccountSidechainApp.class);

        Logger logger = LogManager.getLogger(EonApp.class);
        logger.info("...starting application...");

        sidechainApp.run();
        System.out.println("Horizen EON Sidechain successfully started...");
    }
}
