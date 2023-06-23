// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOneSolution {
  address private gatekeeperOneContract = 0x0358288e4f6584E13130333f6E5FCb15742B33Ab;

  function pastTheGate(bytes8 _gateKey) external returns (bool) {
    // (bool success, ) = address(gatekeeperOneContract).call{gas: 8191}(abi.encodeWithSignature("enter(bytes8)", _gateKey));

    for (uint256 i = 0; i < 120; i++) {
      // (bool result, ) = address(gatekeeperOneContract).call{gas: i + 150 + 8191 * 3}(encodedParams);
      (bool result, ) = address(gatekeeperOneContract).call{gas: i + 150 + 8191 * 3}(abi.encodeWithSignature("enter(bytes8)", _gateKey));
      // require(result, "FAILED TO PASS");
      if (result) {
        break;
      }
    }

    return true;
  }

  event log(uint256 i);

  function passGate() external returns (bool) {
    bytes8 key = bytes8(uint64(uint16(uint160(tx.origin))) + 2 ** 32);

    // NOTE: the proper gas offset to use will vary depending on the compiler
    // version and optimization settings used to deploy the factory contract.
    // To migitage, brute-force a range of possible values of gas to forward.
    // Using call (vs. an abstract interface) prevents reverts from propagating.
    bytes memory encodedParams = abi.encodeWithSignature(("enter(bytes8)"), key);

    bool result;
    // gas offset usually comes in around 210, give a buffer of 60 on each side
    for (uint256 i = 0; i < 120; i++) {
      (result, ) = address(gatekeeperOneContract).call{gas: i + 150 + 8191 * 3}(encodedParams);
      // require(result, "res must be true");
      if (result) {
        emit log(i);
        break;
      }
    }

    return result;
  }
}
