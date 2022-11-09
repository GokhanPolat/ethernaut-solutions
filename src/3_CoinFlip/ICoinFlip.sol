// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface ICoinFlip {
  function flip(bool) external returns (bool);

  function consecutiveWins() external returns (uint256);
}
