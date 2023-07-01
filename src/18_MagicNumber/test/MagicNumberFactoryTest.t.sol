// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import {Test, console2} from "forge-std/Test.sol";
import {MagicNumberFactory} from "../MagicNumberFactory.sol";

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract MagicNumberFactoryTest is Test {
  MagicNumberFactory public magicNumberFactory;

  /// @dev Setup the testing environment.
  function setUp() public {
    magicNumberFactory = new MagicNumberFactory();
  }

  function test_01_deployFactory() external {
    payable(address(magicNumberFactory)).transfer(0.0001 ether);

    address resultAddr = magicNumberFactory.createMagicNumberContract(hex"01");

    console2.log("----------------------------------------------------------");
    // it provided 0x7984896332897090c19F63C7E2a15b03D4813963
    console2.log("resultAddr", resultAddr);
    console2.log("----------------------------------------------------------");

    // assertEq(result, uint256(42));
  }
}
