// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {Utils} from "test/utils/Utils.sol";

import {GatekeeperOneSolution} from "../GatekeeperOneSolution.sol";

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract PrivacyForkTest is Test {
  address private gatekeeperOneContract = 0x0358288e4f6584E13130333f6E5FCb15742B33Ab;
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  GatekeeperOneSolution private gatekeeperOneSolution;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    vm.createSelectFork(stdChains["optimism_goerli"].rpcUrl, 10922420);

    vm.prank(user);
    gatekeeperOneSolution = new GatekeeperOneSolution();
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function _test_01_unlockContract() external {
    vm.prank(user);

    bytes32 slot0 = vm.load(address(gatekeeperOneContract), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000000000000000000000000000000000000000000001

    bytes8 key = bytes8(uint64(uint16(uint160(user))) + 2 ** 32);

    bool result = gatekeeperOneSolution.pastTheGate(key);

    console2.log("----------------------------------------------------------");
    console2.log("result", result);
    console2.log("----------------------------------------------------------");

    slot0 = vm.load(address(gatekeeperOneContract), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000000000000000000000000000000000000000000001

    assert(result);
  }

  function test_01_unlockContract() external {
    vm.prank(user);

    bytes32 slot0 = vm.load(address(gatekeeperOneContract), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000000000000000000000000000000000000000000001

    bool result = gatekeeperOneSolution.passGate();

    console2.log("----------------------------------------------------------");
    console2.log("result", result);
    console2.log("----------------------------------------------------------");

    slot0 = vm.load(address(gatekeeperOneContract), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000000000000000000000000000000000000000000001

    assert(result);
  }
}
