# CONTRACTS ###################################################################
NAUGHTCOIN_FORK_TEST         = ./src/15_NaughtCoin/test/NaughtCoinForkTest.t.sol
NAUGHTCOIN_SCRIPT            = ./src/15_NaughtCoin/script/NaughtCoinScript.s.sol


naughtcoin-test-fork :; ## Optimism Fork NaughtCoin
	${FORGE_TEST_WITH_CONTRACTS} ${NAUGHTCOIN_FORK_TEST}

naughtcoin-attack-optGoerli :; ## Attack to NaughtCoin Contract on OPT Goerli testnet
	${FORGE_SCRIPT} ${NAUGHTCOIN_SCRIPT}:NaughtCoinScript --rpc-url ${RPC_OPTIMISM_GOERLI_ALCHEMY} --broadcast
