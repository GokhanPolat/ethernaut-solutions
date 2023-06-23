# CONTRACTS ###################################################################
KING_TESTS                 = ./src/9_King/test/KingTest.t.sol

king-test-anvil :; ## King test with 'anvil -b 3'
	${FORGE_TEST_WITH_CONTRACTS} ${KING_TESTS} -f http://localhost:8545 $(verbose)

king-hack-optGoerli :; ## Hack King Contract on OPT Goerli testnet
	${FORGE_SCRIPT} ${KING_CONTRACT_SCRIPT}:KingScript --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv
