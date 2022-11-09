// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/src/Test.sol";

// Custom test utils, createUser, mineBlocks etc.
import {Utils} from "test/utils/Utils.sol";

import {ICoinFlip} from "src/3_CoinFlip/ICoinFlip.sol";

// solhint-disable func-name-mixedcase
contract CoinFlipTest is Test {
  // VARIABLES ////////////////////////////////////////////////////////////////
  address private coinFlipAddress = 0x64431fc25f34C618Eabe78371bF6ad106bBb74f3;
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  ICoinFlip private coinFlipInstance = ICoinFlip(coinFlipAddress);

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    vm.createSelectFork(stdChains.OptimismGoerli.rpcUrl, 2546322);
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////
  function test_01_DoFlip() external {
    vm.startPrank(user);

    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    uint256 lastHash;
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 flip = uint256(blockValue / FACTOR);

    bool side = flip == 1 ? true : false;

    lastHash = blockValue;

    coinFlipInstance.flip(side);

    console2.log("----------------------------------------------------------");
    console2.log("coinFlipInstance.consecutiveWins()", coinFlipInstance.consecutiveWins());
    console2.log("----------------------------------------------------------");

    vm.stopPrank();
  }
}
