// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface IReentrance {
  // mapping(address => uint256) public balances;
  function balances(address _address) external returns (uint256);

  function donate(address _to) external payable;

  function balanceOf(address _who) external view returns (uint256 balance);

  function withdraw(uint256 _amount) external payable;

  // function getBalance() external view returns (uint256);

  receive() external payable;
}
