// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
  function owner() external;

  function changeOwner(address _owner) external;
}
