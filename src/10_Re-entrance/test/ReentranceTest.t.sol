// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/src/Test.sol";

// Custom test utils, createUser, mineBlocks etc.
import {Utils} from "test/utils/Utils.sol";

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

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    users = utils.createUsers(5);
    reInstanceDeployer = users[0];
    reAttackDeployer = users[1];

    vm.label(reInstanceDeployer, "reInstanceDeployer");
    vm.label(reAttackDeployer, "reAttackDeployer");

    // Reentrance Instance ////////////////////////////////////////////////////
    vm.prank(reInstanceDeployer);
    reInstance = new Reentrance();
    payable(address(reInstance)).transfer(1e15);

    // King Level Contract ////////////////////////////////////////////////////

    // Reentrance Attack //////////////////////////////////////////////////////
    vm.prank(reAttackDeployer);
    reAttack = new ReentranceAttack(reInstance);
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_PrintAccounts() public {
    console2.log("--------------------- ACCOUNTS ------------------------");
    console2.log("reInstanceDeployer : ", reInstanceDeployer);
    console2.log("reAttackDeployer   : ", reAttackDeployer);
    console2.log("----------------------------------------------------------");

    console2.log("-------------------- CONTRACTS ------------------------");
    console2.log("reInstance : ", address(reInstance));
    console2.log("reAttack   : ", address(reAttack));
    console2.log("-------------------------------------------------------");

    assertTrue(true);
  }

  function test_02_CheckBalances() public {
    // getBalance(address(reInstance));
    console2.log("----------------------------------------------------------");
    console2.log("reInstance.balanceOf(reAttack)           : ", reInstance.balanceOf(address(reAttack)));
    console2.log("reInstance.balanceOf(reInstanceDeployer) : ", reInstance.balanceOf(reInstanceDeployer));
    console2.log("reInstance.balanceOf(reAttackDeployer)   : ", reInstance.balanceOf(reAttackDeployer));
    console2.log("reAttack.balance                         : ", address(reAttack).balance);
    console2.log("reInstance.balance                       : ", address(reInstance).balance);
    console2.log("----------------------------------------------------------");
  }

  function test_03_Attack() public {
    vm.startPrank(reAttackDeployer);

    // Create balance on victim contract //////////////////////////////////////
    reInstance.donate{value: 1e15}(address(reAttack));

    // Trigger withdraw ///////////////////////////////////////////////////////
    // bool res = payable(address(reAttack)).transfer{gas: 1e18}(222e17);

    // (bool success, bytes memory data) = address(reAttack).call{value: 0, gas: 2000000}(abi.encodeWithSignature("", ""));
    // (bool success, bytes memory data) = address(reInstance).call{value: 0, gas: 2000000}(abi.encodeWithSignature("withdraw(uint256)", 1e15));
    reAttack.trigWithdraw();

    vm.stopPrank();

    console2.log("----------------------------------------------------------");
    // console2.log("res", res);
    // console2.log("success", success);
    // console2.log("data");
    // console2.logBytes(data);
    console2.log("----------------------------------------------------------");

    test_02_CheckBalances();
  }
}
