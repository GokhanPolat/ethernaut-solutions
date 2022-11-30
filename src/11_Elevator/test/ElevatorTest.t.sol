// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/src/Test.sol";

import {Utils} from "test/utils/Utils.sol";

import {ElevatorAttack} from "../ElevatorAttack.sol";
import {Elevator} from "../Elevator.sol";

/// solhint-disable func-name-mixedcase
contract ElevatorTest is Test {
  Utils private utils = new Utils();

  // VM USER / PERSONAS /////////////////////////////////////////////////////
  address payable[] private users;
  address payable private elevatorDeployer;
  address payable private attacker;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  Elevator private elevator;
  ElevatorAttack private elevatorAtttack;

  // VARIABLES ////////////////////////////////////////////////////////////////
  // uint256 private max = 2**256 - 1;
  uint256 private max = type(uint256).max;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    users = utils.createUsers(5);
    elevatorDeployer = users[0];
    attacker = users[1];

    vm.label(elevatorDeployer, "elevatorDeployer");
    vm.label(attacker, "attacker");

    vm.prank(elevatorDeployer);
    elevator = new Elevator();

    vm.prank(attacker);
    elevatorAtttack = new ElevatorAttack();
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_PrintAccounts() external {
    console2.log("--------------------- ACCOUNTS ------------------------");
    console2.log("elevatorDeployer : ", elevatorDeployer);
    console2.log("attacker : ", attacker);

    console2.log("-------------------- CONTRACTS ------------------------");
    console2.log("elevator         : ", address(elevator));
    console2.log("elevatorAtttack         : ", address(elevatorAtttack));
    console2.log("-------------------------------------------------------");

    assertTrue(true);
  }

  function test_02_ExploitContract() external {
    bool top = elevator.top();
    uint256 floor = elevator.floor();

    console2.log("----------------------------------------------------------");
    console2.log("BEFORE");
    console2.log("top", top);
    console2.log("floor", floor);
    console2.log("----------------------------------------------------------");

    elevatorAtttack.exploit(address(elevator));

    top = elevator.top();
    floor = elevator.floor();

    console2.log("----------------------------------------------------------");
    console2.log("AFTER");
    console2.log("top", top);
    console2.log("floor", floor);
    console2.log("----------------------------------------------------------");
  }
}
