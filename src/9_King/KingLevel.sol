// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IKing} from "./IKing.sol";

// solhint-disable no-empty-blocks, avoid-low-level-calls
contract KingLevel {
  error IamKing(address sender, string kingsMessage);
  error IamNotKing(address sender, string kingsMessage);

  constructor() {}

  function tryKing(IKing kingContract_) external {
    (bool result, ) = address(kingContract_).call{value: 0}("");
    if (result) revert IamKing({sender: msg.sender, kingsMessage: "I am the King, Level INCOMPLETE"});
    revert IamNotKing({sender: msg.sender, kingsMessage: "I am NOT KING, Level COMPLETED"});
  }
}
