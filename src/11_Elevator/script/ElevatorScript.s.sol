// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/src/Script.sol";

import {ElevatorAttack} from "../ElevatorAttack.sol";

contract ElevatorScript is Script {
  ElevatorAttack private elevatorAttack;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    elevatorAttack = new ElevatorAttack();
    elevatorAttack.exploit(0x2b4B046F1b150e88C033D3Ee69C1182D398A0f7e);

    vm.stopBroadcast();
  }
}
