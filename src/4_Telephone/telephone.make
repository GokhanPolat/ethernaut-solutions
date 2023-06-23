# CONTRACTS ###################################################################
TELEPHONE_SCRIPT           = ./src/4_Telephone/script/Telephone.s.sol

telephone-deploy-optGoerli :; ## Telephone deploy OPT Goerli testnet
	${FORGE_SCRIPT} ${TELEPHONE_SCRIPT}:Telephone --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv
