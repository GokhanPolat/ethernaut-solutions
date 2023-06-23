// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {Utils} from "test/utils/Utils.sol";

import {GatekeeperTwo} from "../GatekeeperTwo.sol";
import {GatekeeperTwoSolution} from "../GatekeeperTwoSolution.sol";

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract GatekeeperTwoTest is Test {
  GatekeeperTwo private gatekeeperTwo;
  GatekeeperTwoSolution private gatekeeperTwoSolution;

  Utils private utils = new Utils();

  // VM USER / PERSONAS /////////////////////////////////////////////////////
  address payable[] private users;
  address private gatekeeperDeployer;
  address private gatekeeperSolutionDeployer;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    users = utils.createUsers(5);
    gatekeeperDeployer = users[0];
    gatekeeperSolutionDeployer = users[1];

    vm.label(gatekeeperDeployer, "gatekeeperDeployer");
    vm.label(gatekeeperSolutionDeployer, "gatekeeperSolutionDeployer");

    vm.prank(gatekeeperDeployer);
    gatekeeperTwo = new GatekeeperTwo();
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////
  function test_00_printAddresses() external {
    console2.log("----------------------------------------------------------");
    console2.log("gatekeeperDeployer        : ", gatekeeperDeployer);
    console2.log("gatekeeperTwo             : ", address(gatekeeperTwo));

    console2.log("gatekeeperSolutionDeployer: ", gatekeeperSolutionDeployer);
    console2.log("gatekeeperTwoSolution     : ", address(gatekeeperTwoSolution));
    console2.log("----------------------------------------------------------");
  }

  function test_01_passGates() external {
    vm.startPrank(gatekeeperSolutionDeployer);

    bytes32 slot0 = vm.load(address(gatekeeperTwo), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000000000000000000000000000000000000000000000

    gatekeeperTwoSolution = new GatekeeperTwoSolution(address(gatekeeperTwo));

    slot0 = vm.load(address(gatekeeperTwo), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000001804c8ab1f12e6bbf3894d4083f33e07309d1f38

    assert(true);
  }
}
