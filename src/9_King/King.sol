// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IKing} from "./IKing.sol";

contract King is IKing {
  address payable private king;
  uint256 public prize;
  address payable public owner;

  constructor() payable {
    owner = payable(msg.sender);
    king = payable(msg.sender);
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner, "not owner, nor high prize");
    king.transfer(msg.value);
    king = payable(msg.sender);
    prize = msg.value;
  }

  function _king() public view returns (address payable) {
    return king;
  }
}
