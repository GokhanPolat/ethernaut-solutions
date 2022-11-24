// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IReentrance} from "./IReentrance.sol";

contract Reentrance is IReentrance {
  mapping(address => uint256) public balances;
  event LOG_INSTANCE(address sender, uint256 value, uint256 gas, string message);

  function donate(address _to) external payable {
    emit LOG_INSTANCE({sender: _to, value: msg.value, gas: gasleft(), message: "donate worked"});
    balances[_to] = balances[_to] + msg.value;
  }

  function balanceOf(address _who) external view returns (uint256 balance) {
    return balances[_who];
  }

  function withdraw(uint256 _amount) external payable {
    emit LOG_INSTANCE({sender: msg.sender, value: _amount, gas: gasleft(), message: "withdraw worked"});

    if (balances[msg.sender] >= _amount) {
      (bool result, ) = msg.sender.call{value: _amount}("");
      emit LOG_INSTANCE({sender: msg.sender, value: _amount, gas: gasleft(), message: "SHOULD NOT RUN"});
      if (result) {
        _amount;
      }

      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}
