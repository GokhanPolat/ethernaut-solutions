# CONTRACTS ###################################################################
REENTRANCE_TEST            = ./src/10_Re-entrance/test/ReentranceTest.t.sol
REENTRANCE_SCRIPT_PATH     = ./src/10_Re-entrance/script/
REENTRANCE_SCRIPT          = ./src/10_Re-entrance/script/ReentranceAttackScript.s.sol

reentrance-test-anvil :; ## Reentrance test with 'anvil -b 3'
	${FORGE_TEST_WITH_CONTRACTS} ${REENTRANCE_TEST} -f http://localhost:8545 $(verbose) --use solc:0.6.12

reentrance-hack-optGoerli :; ## Hack Re-entrance Contract on OPT Goerli testnet
	${FORGE_SCRIPT_WITH_CONTRACTS} ${REENTRANCE_SCRIPT_PATH} ${REENTRANCE_SCRIPT} --rpc-url ${RPC_OPTIMISM_GOERLI} --use solc:0.6.12 --broadcast -vvv
