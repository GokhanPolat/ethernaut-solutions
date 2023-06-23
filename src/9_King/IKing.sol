// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IKing {
  function prize() external returns (uint256);

  function _king() external view returns (address payable);

  receive() external payable;
}
