# CONTRACTS ###################################################################
GATEKEEPER_ONE_TEST       = ./src/13_Gatekeeper_One/test/GatekeeperOneForkTest.t.sol

gatekeeper-one-test-fork :; ## Optimism Fork Gatekeeper One
	${FORGE_TEST_WITH_CONTRACTS} ${GATEKEEPER_ONE_TEST} ${verbose}
