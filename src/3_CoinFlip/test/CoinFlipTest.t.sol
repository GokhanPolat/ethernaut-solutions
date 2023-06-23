// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";

// Custom test utils, createUser, mineBlocks etc.
import {Utils} from "test/utils/Utils.sol";

import {CoinFlip} from "src/3_CoinFlip/contracts/CoinFlip.sol";

// solhint-disable func-name-mixedcase
contract CoinFlipTest is Test {
  Utils private utils = new Utils();

  // VM USER / PERSONAS /////////////////////////////////////////////////////
  address payable[] private users;
  address private coinFlipDeployer;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  CoinFlip private coinflip;

  // VARIABLES ////////////////////////////////////////////////////////////////

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    users = utils.createUsers(5);
    coinFlipDeployer = users[0];

    vm.label(coinFlipDeployer, "coinFlipDeployer");

    // CoinFlip ///////////////////////////////////////////////////////////////
    vm.prank(coinFlipDeployer);
    coinflip = new CoinFlip();
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_PrintAccounts() external {
    console2.log("--------------------- ACCOUNTS ------------------------");
    console2.log("coinFlipDeployer  : ", coinFlipDeployer);

    console2.log("-------------------- CONTRACTS ------------------------");
    console2.log("coinflip         : ", address(coinflip));
    console2.log("-------------------------------------------------------");

    assertTrue(true);
  }

  function test_02_DoFlip() external {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    uint256 lastHash;
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 flip = uint256(blockValue / FACTOR);

    bool side = flip == 1 ? true : false;

    lastHash = blockValue;
    coinflip.flip(side);

    console2.log("----------------------------------------------------------");
    console2.log("blockValue", blockValue);
    console2.log("FACTOR", FACTOR);
    console2.log("flip", flip);
    console2.log("blockValue / FACTOR", uint256(blockValue / FACTOR));
    console2.log("----------------------------------------------------------");

    console2.log("last blockhash: ");
    console2.logBytes32(blockhash(block.number - 1));
    console2.log("block.number: ", block.number);
    console2.log("side : ", side);
    console2.log("----------------------------------------------------------");
  }
}
