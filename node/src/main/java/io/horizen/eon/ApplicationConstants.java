package io.horizen.eon;

public class ApplicationConstants {

    private ApplicationConstants() {}

    // Network ids
    static final long REGTEST_ID = 1997L;
    static final long TESTNET_ID = 1663L;
    static final long MAINNET_ID = 7332L;

    static final int MAINCHAIN_BLOCK_REFERENCE_DELAY = 6; // in number of mainchain blocks
    static final int MAX_HISTORY_REWRITING_LENGTH = 100; // max number of SC blocks that can be reverted; in number of SC blocks

    public static final String PREGOBI_SIDECHAINID = "1f758350754c12ac8f75a547f745b75eb744b382e15d0d3b0e24a4b5c5acde00";
    public static final String GOBI_SIDECHAINID = "264a664c87d438b6983e0e071293e0e50b37eb12976eaa2dcd08d6a1ee16ca71";
}
