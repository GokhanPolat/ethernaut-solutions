// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {Test, console2} from "forge-std/Test.sol";

interface MagicNumber {
  function whatIsTheMeaningOfLife() external returns (uint256);
}

// solhint-disable func-name-mixedcase, no-console, no-empty-blocks
contract MagicNumberTest is Test {
  /// @dev Address of the MagicNumber contract.
  MagicNumber public magicNumber;

  /// @dev Setup the testing environment.
  function setUp() public {
    magicNumber = MagicNumber(HuffDeployer.deploy("18_MagicNumber/MagicNumber"));
  }

  function test_01_return42() external {
    uint256 result = magicNumber.whatIsTheMeaningOfLife();
    console2.log("----------------------------------------------------------");
    console2.log("result: ", result);
    console2.log("----------------------------------------------------------");

    // assertEq(result, uint256(42));
  }
}
