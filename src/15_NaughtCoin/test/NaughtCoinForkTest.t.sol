// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {Utils} from "test/utils/Utils.sol";

import {NaughtCoinSolution} from "../NaughtCoinSolution.sol";

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract NaughtCoinForkTest is Test {
  address private naughtCoinContract = 0x6C74C66ECC7d5E503585D49885FBE90085E0815D;
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  NaughtCoinSolution private naughtCoinSolution;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    vm.createSelectFork(stdChains["optimism_goerli"].rpcUrl, 11058172);
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_unlockContract() external {
    vm.startPrank(user);

    naughtCoinSolution = new NaughtCoinSolution();
    uint256 _balance;

    {
      // uint256 _balance = address(naughtCoinContract).balanceOf(user);
      (bool successBalance, bytes memory dataBalance) = naughtCoinContract.call(abi.encodeWithSignature("balanceOf(address)", user));

      console2.log("----------------------------------------------------------");
      console2.log("successBalance: ", successBalance);

      _balance = uint256(bytes32(dataBalance));
      console2.log("_balance: ", _balance);
      console2.log("----------------------------------------------------------");

      (bool successApprove, bytes memory dataApprove) = naughtCoinContract.call(
        abi.encodeWithSignature("approve(address,uint256)", naughtCoinSolution, _balance)
      );

      console2.log("----------------------------------------------------------");
      console2.log("successApprove: ", successApprove);

      uint256 _approve = uint256(bytes32(dataApprove));
      console2.log("_approve: ", _approve);
      console2.log("----------------------------------------------------------");
    }

    naughtCoinSolution.getAllBalance(_balance);

    {
      // uint256 _balance = address(naughtCoinContract).balanceOf(user);
      (bool successBalance, bytes memory dataBalance) = naughtCoinContract.call(abi.encodeWithSignature("balanceOf(address)", user));

      console2.log("----------------------------------------------------------");
      console2.log("successBalance: ", successBalance);

      uint256 _balance = uint256(bytes32(dataBalance));
      console2.log("_balance: ", _balance);
      console2.log("----------------------------------------------------------");
    }

    vm.stopPrank();
    assert(true);
  }
}
