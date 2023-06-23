// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {PrivacySolution} from "../PrivacySolution.sol";

contract PrivacyScript is Script {
  PrivacySolution private privacySolution;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    bytes32 _slot5 = 0xbd92eb6003f98e3362cc82206aa04fce6b2eddedd49e0b74abe3674cfea18f24;
    bytes16 _key = bytes16(_slot5);

    privacySolution = new PrivacySolution();
    privacySolution.callUnlock(_key);

    vm.stopBroadcast();
  }
}
