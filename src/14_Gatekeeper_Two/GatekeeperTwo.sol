// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperTwo {
  address public entrant;

  event log_str(string str);
  event log_bool(bool b);
  event log_uint(uint256 i);
  event log_addr(address addr);
  event log_b8(bytes8 b8);

  modifier gateOne() {
    require(msg.sender != tx.origin, "msg.sender == tx.origin");
    // emit log_bool(true);
    emit log_str("gate 1 PASS");
    _;
  }

  modifier gateTwo() {
    uint x;
    address cllr;
    assembly {
      cllr := caller()
      x := extcodesize(caller())
    }
    emit log_addr(cllr);
    emit log_uint(x);

    require(x == 0, "extcodesize(caller()) != 0");

    emit log_str("gate 2 PASS");
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    emit log_str("gate 3 PASS");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
