// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {TelephoneSolution} from "../TelephoneSolution.sol";
import {ITelephone} from "../ITelephone.sol";

contract Telephone is Script {
  TelephoneSolution private telSolution;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    telSolution = new TelephoneSolution();

    vm.stopBroadcast();
  }
}
