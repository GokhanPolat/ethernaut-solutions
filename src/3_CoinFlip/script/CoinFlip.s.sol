// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {CoinFlipSolution} from "src/3_CoinFlip/CoinFlipSolution.sol";
import {ICoinFlip} from "src/3_CoinFlip/ICoinFlip.sol";

contract CoinFlip is Script {
  // https://goerli-optimism.etherscan.io/address/0x64431fc25f34C618Eabe78371bF6ad106bBb74f3
  ICoinFlip private coinFlipInstance = ICoinFlip(0x64431fc25f34C618Eabe78371bF6ad106bBb74f3);

  CoinFlipSolution private coinFlipSolution;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    coinFlipSolution = new CoinFlipSolution(address(coinFlipInstance));

    vm.stopBroadcast();
  }
}

contract CoinFlipHack is Script {
  CoinFlipSolution private coinFlipSolutionInstance;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    // This deployed address took from broadcast/.../.../run-latest.json file when deployed.
    coinFlipSolutionInstance = CoinFlipSolution(0xDE7D94638EEe12c8E298E7514D8A74a824752f43);
    coinFlipSolutionInstance.doFlip();

    vm.stopBroadcast();
  }
}
