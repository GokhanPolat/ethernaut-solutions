# CONTRACTS ###################################################################
COINFLIP_TEST              = ./src/3_CoinFlip/test/CoinFlipTest.t.sol
COINFLIP_SCRIPT            = ./src/3_CoinFlip/script/CoinFlip.s.sol

# Best for testing which are we see functions working or not.
# Working files: only test file and interfaces if needed.
coinflip-test-fork :; ## Optimism Fork CoinFlip
	${FORGE_TEST_WITH_CONTRACTS} ${COINFLIP_TEST} ${verbose} --gas-report

# Best for hacking on real network, deploy do tx and write script etc.
# Working files: Actual contracts, hack contracts, scripts,
# deploy all off them and make real txs.
coinflip-test-anvil :; ## CoinFlip test with 'anvil -b 3'
	${FORGE_TEST_WITH_CONTRACTS} ${COINFLIP_TEST} -f http://localhost:8545 $(verbose) --gas-report

coinflip-deploy-optGoerli :; ## CoinFlip deploy OPT Goerli testnet
	${FORGE_SCRIPT} ${COINFLIP_SCRIPT}:CoinFlip --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv

coinflip-hack-optGoerli :; ## Hack CoinFlip Contract on OPT Goerli testnet
	${FORGE_SCRIPT} ${COINFLIP_SCRIPT}:CoinFlipHack --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv
