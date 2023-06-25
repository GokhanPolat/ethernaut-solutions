# CONTRACTS ###################################################################
PRESERVATION_FORK_TEST         = ./src/16_Preservation/test/PreservationForkTest.t.sol
PRESERVATION_SCRIPT            = ./src/16_Preservation/script/PreservationScript.s.sol


preservation-test-fork :; ## Optimism Fork Preservation
	${FORGE_TEST_WITH_CONTRACTS} ${PRESERVATION_FORK_TEST}

preservation-attack-optGoerli :; ## Attack to Preservation Contract on OPT Goerli testnet
	${FORGE_SCRIPT} ${PRESERVATION_SCRIPT}:PreservationScript --rpc-url ${RPC_OPTIMISM_GOERLI_ALCHEMY} --broadcast
