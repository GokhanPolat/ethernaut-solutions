# CONTRACTS ###################################################################
MAGICNUMBER_TEST           = ./src/18_MagicNumber/test/MagicNumberTest.t.sol
MAGICNUMBER_FACTORY_TEST   = ./src/18_MagicNumber/test/MagicNumberFactoryTest.t.sol
MAGICNUMBER_FORK_TEST      = ./src/18_MagicNumber/test/MagicNumberForkTest.t.sol
MAGICNUMBER_SCRIPT_PATH    = ./src/18_MagicNumber/script
MAGICNUMBER_FACTORY_SCRIPT = ./src/18_MagicNumber/script/MagicNumberFactoryScript.s.sol

magicNumber-test-anvil :; ## MagicNumber test with 'anvil -b 3'
	${FORGE_TEST_WITH_CONTRACTS} ${MAGICNUMBER_TEST} -f http://localhost:8545 -vvvv --gas-report

magicNumber-attack-optGoerli :; ## Attack to MagicNumber Contract on OPT Goerli testnet
	${FORGE_SCRIPT} ${MAGICNUMBER_FACTORY_SCRIPT}:MagicNumberFactoryScript --rpc-url ${RPC_OPTIMISM_GOERLI_ALCHEMY} --broadcast -vvvv
