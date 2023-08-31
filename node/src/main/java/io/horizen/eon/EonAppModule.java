package io.horizen.eon;

import com.google.inject.TypeLiteral;
import com.google.inject.name.Names;
import io.horizen.ChainInfo;
import io.horizen.SidechainAppStopper;
import io.horizen.SidechainSettings;
import io.horizen.account.AccountAppModule;
import io.horizen.account.state.EvmMessageProcessor;
import io.horizen.account.state.MessageProcessor;
import io.horizen.account.transaction.AccountTransaction;
import io.horizen.account.api.http.AccountApplicationApiGroup;
import io.horizen.fork.ForkConfigurator;
import io.horizen.proof.Proof;
import io.horizen.proposition.Proposition;
import io.horizen.secret.Secret;
import io.horizen.secret.SecretSerializer;
import io.horizen.settings.SettingsReader;
import io.horizen.transaction.TransactionSerializer;
import io.horizen.utils.Pair;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import static io.horizen.eon.ApplicationConstants.*;

public class EonAppModule extends AccountAppModule {
    private final SettingsReader settingsReader;

    public EonAppModule(String userSettingsFileName) {
        this.settingsReader = new SettingsReader(userSettingsFileName, Optional.empty());
    }

    @Override
    public void configureApp() {
        // Set networks ids
        ChainInfo chainInfo = new ChainInfo(REGTEST_ID, TESTNET_ID, MAINNET_ID);

        // Add support of the EVM
        List<MessageProcessor> customMessageProcessors = new ArrayList<>();
        customMessageProcessors.add(new EvmMessageProcessor());

        SidechainAppStopper applicationStopper = new EonAppStopper();

        SidechainSettings sidechainSettings = this.settingsReader.getSidechainSettings();
        EonForkConfigurator forkConfigurator= new EonForkConfigurator(Optional.of(sidechainSettings.genesisData().scId()));

        HashMap<Byte, SecretSerializer<Secret>> customSecretSerializers = new HashMap<>();
        HashMap<Byte, TransactionSerializer<AccountTransaction<Proposition, Proof<Proposition>>>>
                customAccountTransactionSerializers = new HashMap<>();

        // No custom API
        List<AccountApplicationApiGroup> customApiGroups = new ArrayList<>();

        // No rejected SDK core API
        List<Pair<String, String>> rejectedApiPaths = new ArrayList<>();


        bind(SidechainSettings.class)
                .annotatedWith(Names.named("SidechainSettings"))
                .toInstance(sidechainSettings);

        bind(new TypeLiteral<HashMap<Byte, SecretSerializer<Secret>>>() {})
                .annotatedWith(Names.named("CustomSecretSerializers"))
                .toInstance(customSecretSerializers);

        bind(new TypeLiteral<HashMap<Byte, TransactionSerializer<AccountTransaction<Proposition, Proof<Proposition>>>>>() {})
                .annotatedWith(Names.named("CustomAccountTransactionSerializers"))
                .toInstance(customAccountTransactionSerializers);

        bind(new TypeLiteral<List<AccountApplicationApiGroup>>() {})
                .annotatedWith(Names.named("CustomApiGroups"))
                .toInstance(customApiGroups);

        bind(new TypeLiteral<List<Pair<String, String>>>() {})
                .annotatedWith(Names.named("RejectedApiPaths"))
                .toInstance(rejectedApiPaths);

        bind(SidechainAppStopper.class)
                .annotatedWith(Names.named("ApplicationStopper"))
                .toInstance(applicationStopper);

        bind(ForkConfigurator.class)
                .annotatedWith(Names.named("ForkConfiguration"))
                .toInstance(forkConfigurator);

        bind(ChainInfo.class)
                .annotatedWith(Names.named("ChainInfo"))
                .toInstance(chainInfo);
        bind(new TypeLiteral<List<MessageProcessor>>() {})
                .annotatedWith(Names.named("CustomMessageProcessors"))
                .toInstance(customMessageProcessors);

        bind(Integer.class)
                .annotatedWith(Names.named("MainchainBlockReferenceDelay"))
                .toInstance(MAINCHAIN_BLOCK_REFERENCE_DELAY);

        bind(String.class)
                .annotatedWith(Names.named("AppVersion"))
                .toInstance(getEONVersion());
    }

    /**
     Retrieves the EON version by dynamically accessing the implementation version of the package at runtime.
     The implementation version is taken from the JAR file's manifest file <b>Implementation-Version</b> attribute. That attribute
     is populated when JAR is built with the value of the version tag under the project key from the pom file. <br/>
     When running the application in a development environment (e.g., directly from the source code or an IDE), the implementation
     version is not accessible and will return the default "dev" value.

     @return The EON version, or "dev" if the version is not available.
     */
    public String getEONVersion() {
        String defaultVersion = "dev";
        Package eonPackage = this.getClass().getPackage();
        String version = eonPackage.getImplementationVersion();
        return version != null ? version : defaultVersion;
    }
}
