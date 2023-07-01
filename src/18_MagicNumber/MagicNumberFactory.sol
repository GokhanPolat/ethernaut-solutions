// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// solhint-disable no-inline-assembly
contract MagicNumberFactory {
  // this runtime code taken from huffc
  // huffc -zbr src/18_MagicNumber/MagicNumber.huff
  bytes private contractBytecode = hex"600a8060093d393df3602a60005260206000f3";

  function createMagicNumberContract(bytes32 salt) public returns (address addr) {
    bytes memory bytecode = contractBytecode;

    assembly {
      addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
    }
  }

  receive() external payable {}
}
