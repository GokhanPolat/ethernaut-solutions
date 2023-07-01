// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/Test.sol";
import {MagicNumberFactory} from "../MagicNumberFactory.sol";

// solhint-disable no-console, avoid-low-level-calls
contract MagicNumberFactoryScript is Script {
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;
  address private instance = 0x8883dd34a0824BbE07CCfd4226020b24397Ea120;

  MagicNumberFactory private magicNumberFactory;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    magicNumberFactory = new MagicNumberFactory();

    payable(address(magicNumberFactory)).transfer(0.0001 ether);

    address resultAddr = magicNumberFactory.createMagicNumberContract(hex"01");

    console2.log("----------------------------------------------------------");
    console2.log("resultAddr", resultAddr);
    console2.log("----------------------------------------------------------");

    (bool succ, ) = instance.call(abi.encodeWithSignature("setSolver(address)", resultAddr));
    vm.stopBroadcast();
  }
}
