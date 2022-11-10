###############################################################################
#																																							#
# Makefile for foundry																												#
#																																							#
# License : MIT																																#
# Author  : Gokhan Polat																											#
# Date    : 2022/10/25																												#
#																																							#
# Description:																																#
# ------------																																#
# type "make" or "make help" to see commands																	#
#																																							#
###############################################################################


# ENV and DEFAULTS ############################################################
# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env
.DEFAULT_GOAL := help
.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


_verbose_ :; ## for test verbosity use 'verbose=vvv' at the end of command, v count can be up 5, include 5

###############################################################################
#                                  VARIABLES                                  #
###############################################################################
FORGE_TEST_WITH_PATH      = forge test --match-path
FORGE_TEST_WITH_CONTRACTS = forge test --contracts
FORGE_SCRIPT              = forge script
IGNORE_FLYCHECK           = --no-match-contract=flycheck

# SOLC_OPENZEPPELIN_REMAPPING = openzeppelin-contracts=lib/openzeppelin-contracts


# CONTRACTS ###################################################################
COINFLIP_CONTRACT     = ./src/3_CoinFlip/CoinFlipSolution.sol
COINFLIP_TESTS        = ./src/3_CoinFlip/test/CoinFlipTest.t.sol
COINFLIP_SCRIPT       = ./src/3_CoinFlip/script/CoinFlip.s.sol

TELEPHONE_SCRIPT      = ./src/4_Telephone/script/Telephone.s.sol

FORCE_CONTRACT_SCRIPT = ./src/7_Force/script/Force.s.sol

###############################################################################
#                                  forge commands                             #
###############################################################################
install       :; forge install               ## Install project dependencies
update        :; forge update                ## Update project dependencies
build         :; forge build                 ## Build the project's smart contracts
trace-report  :; forge test -vv --gas-report ## Run tests with gas reporting
clean         :; forge clean                 ## Remove the build artifacts and cache directories
snapshot      :; forge snapshot              ## Create a snapshot of each test's gas usage
# fmt           :; forge fmt                  ### Formats Solidity source files
# test        :; forge test                   ### Run the project's tests
# trace       :; forge test -vv               ### Run the project's tests with verbose level 2
# trace-watch :; forge test -vv -watch        ### Run the project's tests with verbose level 2 and watch



###############################################################################
#                                   COINFLIP                                  #
###############################################################################
# TESTS #######################################################################

# Best for testing which are we see functions working or not.
# Working files: only test file and interfaces if needed.
coinflip-test-fork    :; ## Optimism Fork CoinFlip
	${FORGE_TEST_WITH_CONTRACTS} ${COINFLIP_TESTS} ${verbose} --gas-report

# HACKING #####################################################################
# Best for hacking on real network, deploy do tx and write script etc.
# Working files: Actual contracts, hack contracts, scripts,
# deploy all off them and make real txs.
coinflip-test-anvil     :; ## CoinFlip test with 'anvil -b 3'
	${FORGE_TEST_WITH_PATH} ${COINFLIP_TESTS} -f http://localhost:8545 $(verbose) --gas-report

coinflip-deploy-goerli  :; ## CoinFlip deploy OPT Goerli testnet
	forge script ${COINFLIP_SCRIPT}:CoinFlip --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv

coinflip-hack-goerli    :; ## Hack CoinFlip Contract on OPT Goerli testnet
	forge script ${COINFLIP_SCRIPT}:CoinFlipHack --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv

###############################################################################
#                                 4_TELEPHONE                                 #
###############################################################################
# EXPLOIT #####################################################################
telephone-deploy-goerli  :; ## CoinFlip deploy OPT Goerli testnet
	forge script ${TELEPHONE_SCRIPT}:Telephone --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv

###############################################################################
#                                   7_FORCE                                   #
###############################################################################
# EXPLOIT #####################################################################
forcesolution-hack-goerli  :; ## ForceSolution, deploy OPT Goerli testnet
	${FORGE_SCRIPT} ${FORCE_CONTRACT_SCRIPT}:Force --rpc-url ${RPC_OPTIMISM_GOERLI} --broadcast -vvv
