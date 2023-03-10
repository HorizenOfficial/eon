package io.horizen.examples;

import com.google.inject.TypeLiteral;
import com.google.inject.name.Names;
import io.horizen.ChainInfo;
import io.horizen.SidechainAppStopper;
import io.horizen.SidechainSettings;
import io.horizen.account.AccountAppModule;
import io.horizen.account.state.EvmMessageProcessor;
import io.horizen.account.state.MessageProcessor;
import io.horizen.account.transaction.AccountTransaction;
import io.horizen.api.http.ApplicationApiGroup;
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

import static io.horizen.examples.ApplicationConstants.*;

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
        AppForkConfigurator forkConfigurator = new AppForkConfigurator();
        SidechainSettings sidechainSettings = this.settingsReader.getSidechainSettings();

        HashMap<Byte, SecretSerializer<Secret>> customSecretSerializers = new HashMap<>();
        HashMap<Byte, TransactionSerializer<AccountTransaction<Proposition, Proof<Proposition>>>>
                customAccountTransactionSerializers = new HashMap<>();

        // No custom API
        List<ApplicationApiGroup> customApiGroups = new ArrayList<>();

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

        bind(new TypeLiteral<List<ApplicationApiGroup>>() {})
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
                .annotatedWith(Names.named("ConsensusSecondsInSlot"))
                .toInstance(CONSENSUS_SLOT_TIME);
    }
}
