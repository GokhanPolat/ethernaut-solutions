// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

contract Reentrance {
  mapping(address => uint256) public balances;

  constructor() public payable {}

  function donate(address _to) external payable {
    balances[_to] = balances[_to] + msg.value;
  }

  function balanceOf(address _who) external view returns (uint256 balance) {
    return balances[_who];
  }

  function withdraw(uint256 _amount) external payable {
    if (balances[msg.sender] >= _amount) {
      (bool result, ) = msg.sender.call{value: _amount}("");
      if (result) {
        _amount;
      }

      balances[msg.sender] -= _amount;
      // balances[msg.sender] = 0;
    }
  }

  receive() external payable {}
}
