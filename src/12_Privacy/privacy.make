# CONTRACTS ###################################################################
PRIVACY_TEST              = ./src/12_Privacy/test/PrivacyForkTest.t.sol
PRIVACY_SCRIPT            = ./src/12_Privacy/script/PrivacyScript.s.sol

privacy-test-fork :; ## Optimism Fork Privacy
	${FORGE_TEST_WITH_CONTRACTS} ${PRIVACY_TEST} ${verbose}

privacy-optGoerli :; ## PrivacySolution, deploy OPT Goerli testnet
	${FORGE_SCRIPT} ${PRIVACY_SCRIPT}:PrivacyScript --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv
