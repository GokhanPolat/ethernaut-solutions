# CONTRACTS ###################################################################
RECOVERY_FORK_TEST         = ./src/17_Recovery/test/RecoveryForkTest.t.sol
RECOVERY_SCRIPT            = ./src/17_Recovery/script/RecoveryScript.s.sol


recovery-test-fork :; ## Optimism Fork Recovery
	${FORGE_TEST_WITH_CONTRACTS} ${RECOVERY_FORK_TEST}

recovery-attack-optGoerli :; ## Attack to Recovery Contract on OPT Goerli testnet
	${FORGE_SCRIPT} ${RECOVERY_SCRIPT}:RecoveryScript --rpc-url ${RPC_OPTIMISM_GOERLI_ALCHEMY} --broadcast
