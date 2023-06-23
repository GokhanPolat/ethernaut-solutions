# CONTRACTS ###################################################################
ELEVATOR_TEST              = ./src/11_Elevator/test/ElevatorTest.t.sol
ELEVATOR_SCRIPT_PATH       = ./src/11_Elevator/script/
ELEVATOR_SCRIPT            = ./src/11_Elevator/script/ElevatorScript.s.sol

elevator-test-anvil :; ## Elevator test with 'anvil -b 3'
	${FORGE_TEST_WITH_CONTRACTS} ${ELEVATOR_TEST} -f http://localhost:8545 $(verbose)

elevator-hack-optGoerli :; ## Exploiting Elevator Contract on OPT Goerli testnet
	${FORGE_SCRIPT_WITH_CONTRACTS} ${ELEVATOR_SCRIPT_PATH} ${ELEVATOR_SCRIPT} --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv
