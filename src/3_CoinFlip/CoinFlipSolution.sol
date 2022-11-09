// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ICoinFlip.sol";

/// solhint-disable reason-string
contract CoinFlipSolution {
  ICoinFlip private _token;

  /////////////////////////////////////////////////////////////////////////////
  //                               CONSTRUCTOR                               //
  /////////////////////////////////////////////////////////////////////////////
  constructor(address token_) {
    _token = ICoinFlip(token_);
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                FUNCTIONS                                //
  /////////////////////////////////////////////////////////////////////////////
  function doFlip() external {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    uint256 lastHash;
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 flip = uint256(blockValue / FACTOR);

    bool side = flip == 1 ? true : false;

    lastHash = blockValue;
    _token.flip(side);
  }
}
