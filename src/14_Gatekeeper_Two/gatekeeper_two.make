# CONTRACTS ###################################################################
GATEKEEPER_TWO_TEST              = ./src/14_Gatekeeper_Two/test/GatekeeperTwoTest.t.sol
GATEKEEPER_TWO_FORK_TEST         = ./src/14_Gatekeeper_Two/test/GatekeeperTwoForkTest.t.sol
GATEKEEPER_TWO_SCRIPT            = ./src/14_Gatekeeper_Two/script/GatekeeperTwoScript.s.sol



gatekeeper-two-test-anvil :; ## Gatekeeper Two test with 'anvil -b 3'
	${FORGE_TEST_WITH_CONTRACTS} ${GATEKEEPER_TWO_TEST} -f http://localhost:8545 $(verbose)

gatekeeper-two-test-fork :; ## Optimism Fork Gatekeeper Two
	${FORGE_TEST_WITH_CONTRACTS} ${GATEKEEPER_TWO_FORK_TEST}

gatekeeper-two-attack-optGoerli :; ## Attack to Gatekeeper Two Contract on OPT Goerli testnet
	${FORGE_SCRIPT} ${GATEKEEPER_TWO_SCRIPT}:GatekeeperTwoScript --rpc-url ${RPC_OPTIMISM_GOERLI_ALCHEMY} --broadcast
