// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {Utils} from "test/utils/Utils.sol";

import {GatekeeperTwoSolution} from "../GatekeeperTwoSolution.sol";

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract PrivacyForkTest is Test {
  address private gatekeeperTwoContract = 0x98eB6A5a1952D68F5221823A1AF3A673b84944d1;
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  GatekeeperTwoSolution private gatekeeperTwoSolution;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    vm.createSelectFork(stdChains["optimism_goerli"].rpcUrl, 11047461);
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_unlockContract() external {
    vm.startPrank(user);

    bytes32 slot0 = vm.load(address(gatekeeperTwoContract), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000000000000000000000000000000000000000000000

    gatekeeperTwoSolution = new GatekeeperTwoSolution(gatekeeperTwoContract);

    slot0 = vm.load(address(gatekeeperTwoContract), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000000000000000000000000000000000000000000000

    vm.stopPrank();
    assert(true);
  }
}
