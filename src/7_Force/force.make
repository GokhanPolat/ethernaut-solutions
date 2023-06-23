# CONTRACTS ###################################################################
FORCE_SCRIPT               = ./src/7_Force/script/Force.s.sol

forcesolution-hack-optGoerli :; ## ForceSolution, deploy OPT Goerli testnet
	${FORGE_SCRIPT} ${FORCE_SCRIPT}:Force --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv
