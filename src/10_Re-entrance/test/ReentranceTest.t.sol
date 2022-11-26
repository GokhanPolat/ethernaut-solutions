// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "forge-std/src/Test.sol";

// Custom test utils, createUser, mineBlocks etc.
// import "test/utils/Utils.sol";

import "src/10_Re-entrance/Reentrance.sol";
import "src/10_Re-entrance/ReentranceAttack.sol";

/// solhint-disable func-name-mixedcase
contract ReentranceTest is Test {
  // Utils private utils = new Utils();

  // VM USER / PERSONAS /////////////////////////////////////////////////////
  // address payable[] private users;
  address payable private reInstanceDeployer;
  address payable private reAttackDeployer;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  Reentrance private reInstance;
  ReentranceAttack private reAttack;

  // VARIABLES ////////////////////////////////////////////////////////////////

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    // users = utils.createUsers(5);
    reInstanceDeployer = payable(vm.addr(1)); // users[0];
    reAttackDeployer = payable(vm.addr(2)); // users[1];

    vm.label(reInstanceDeployer, "reInstanceDeployer");
    vm.label(reAttackDeployer, "reAttackDeployer");

    // Reentrance Instance ////////////////////////////////////////////////////
    vm.prank(reInstanceDeployer);
    reInstance = new Reentrance{value: 1 ether}();
    // payable(address(reInstance)).transfer(1 ether);

    // King Level Contract ////////////////////////////////////////////////////

    // Reentrance Attack //////////////////////////////////////////////////////
    vm.prank(reAttackDeployer);
    reAttack = new ReentranceAttack(address(reInstance));
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
    console2.log("----------------------------------------------------------");
    console2.log("reInstance.balanceOf(reAttack)           : ", reInstance.balanceOf(address(reAttack)));
    console2.log("reInstance.balance                       : ", address(reInstance).balance);
    console2.log("reAttack.balance                         : ", address(reAttack).balance);
    console2.log("----------------------------------------------------------");
  }

  function test_03_Attack() public {
    vm.startPrank(reAttackDeployer);

    // Create balance on victim contract //////////////////////////////////////
    // reInstance.donate{value: 1e15}(address(reAttack));

    // Trigger withdraw ///////////////////////////////////////////////////////
    // bool res = payable(address(reAttack)).transfer{gas: 1e18}(222e17);

    // (bool success, bytes memory data) = address(reAttack).call{value: 0, gas: 2000000}(abi.encodeWithSignature("", ""));
    // (bool success, bytes memory data) = address(reInstance).call{value: 0, gas: 2000000}(abi.encodeWithSignature("withdraw(uint256)", 1e15));
    // reAttack.trigWithdraw{value: 1e15}();

    // vm.expectRevert();
    // reAttack.attack{value: 1 ether}();
    // address(reAttack).call{value: 1 ether}(abi.encodeWithSignature("attack()"));
    // assertTrue(status, "expectRevert: call did not revert");

    // vm.expectRevert();
    // reAttack.attack_1_causeOverflow();

    // vm.expectRevert();
    // reAttack.attack_2_deplete();

    // address(reAttack).call{value: 1}("");

    // reAttack.exploit{value: 1 ether}(payable(address(reInstance)));

    vm.stopPrank();

    test_02_CheckBalances();
  }
}
