// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "forge-std/src/Test.sol";

// Custom test utils, createUser, mineBlocks etc.
import {Utils} from "test/utils/Utils.sol";

import {IReentrance} from "src/10_Re-entrance/IReentrance.sol";
import {Reentrance} from "src/10_Re-entrance/Reentrance.sol";
import {ReentranceAttack} from "src/10_Re-entrance/ReentranceAttack.sol";

/// solhint-disable func-name-mixedcase
contract ReentranceTest is Test {
  Utils private utils = new Utils();

  // VM USER / PERSONAS /////////////////////////////////////////////////////
  address payable[] private users;
  address payable private reInstanceDeployer;
  address payable private reAttackDeployer;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  Reentrance private reInstance;
  ReentranceAttack private reAttack;

  // VARIABLES ////////////////////////////////////////////////////////////////
  uint256 private initialBalanceOfInstance = 1e15;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    users = utils.createUsers(5);
    reInstanceDeployer = users[0];
    reAttackDeployer = users[1];

    vm.label(reInstanceDeployer, "reInstanceDeployer");
    vm.label(reAttackDeployer, "reAttackDeployer");

    // Reentrance Instance ////////////////////////////////////////////////////
    vm.prank(reInstanceDeployer);
    reInstance = new Reentrance{value: initialBalanceOfInstance}();

    // Reentrance Attack //////////////////////////////////////////////////////
    vm.prank(reAttackDeployer);
    reAttack = new ReentranceAttack(address(reInstance), payable(address(reAttackDeployer)));
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_PrintAccounts() public view {
    console2.log("--------------------- ACCOUNTS ------------------------");
    console2.log("reInstanceDeployer : ", reInstanceDeployer);
    console2.log("reAttackDeployer   : ", reAttackDeployer);
    console2.log("----------------------------------------------------------");

    console2.log("-------------------- CONTRACTS ------------------------");
    console2.log("reInstance : ", address(reInstance));
    console2.log("reAttack   : ", address(reAttack));
    console2.log("-------------------------------------------------------");
  }

  function test_02_CheckBalances() public view {
    console2.log("----------------------------------------------------------");
    console2.log("reInstance.balanceOf(reAttack) : ", reInstance.balanceOf(address(reAttack)));
    console2.log("reInstance.balance             : ", address(reInstance).balance);
    console2.log("reAttack.balance               : ", address(reAttack).balance);
    console2.log("reAttackDeployer.balance       : ", address(reAttackDeployer).balance);
    console2.log("----------------------------------------------------------");
  }

  function test_03_Attack() public {
    vm.startPrank(reAttackDeployer);

    initialBalanceOfInstance = address(reInstance).balance;

    reAttack.attack{value: initialBalanceOfInstance}();
    reAttack.kill();

    test_02_CheckBalances();

    vm.stopPrank();
  }
}
