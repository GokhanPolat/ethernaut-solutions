// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import {ForceSolution} from "../ForceSolution.sol";

contract Force is Script {
  ForceSolution private forceSolution;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    forceSolution = new ForceSolution();

    payable(address(forceSolution)).transfer(1);

    forceSolution.forceETH();

    vm.stopBroadcast();
  }
}
