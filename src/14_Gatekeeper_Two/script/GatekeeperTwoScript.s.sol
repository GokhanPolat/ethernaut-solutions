// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {GatekeeperTwoSolution} from "../GatekeeperTwoSolution.sol";

contract GatekeeperTwoScript is Script {
  GatekeeperTwoSolution private gatekeeperTwoSolution;
  address private gatekeeperTwoContract = 0x98eB6A5a1952D68F5221823A1AF3A673b84944d1;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    gatekeeperTwoSolution = new GatekeeperTwoSolution(gatekeeperTwoContract);

    vm.stopBroadcast();
  }
}
