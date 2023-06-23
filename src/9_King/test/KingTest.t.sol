// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";

// Custom test utils, createUser, mineBlocks etc.
import {Utils} from "test/utils/Utils.sol";

import {King} from "src/9_King/King.sol";
import {IKing} from "src/9_King/IKing.sol";
import {KingLevel} from "src/9_King/KingLevel.sol";
import {KingSolution} from "src/9_King/KingSolution.sol";

/// solhint-disable func-name-mixedcase
contract KingTest is Test {
  Utils private utils = new Utils();

  // VM USER / PERSONAS /////////////////////////////////////////////////////
  address payable[] private users;
  address payable private kingDeployer;
  address payable private kingLevelDeployer;
  address payable private kingSolutionDeployer;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  King private king;
  KingLevel private kingLevel;
  KingSolution private kingSolution;

  // VARIABLES ////////////////////////////////////////////////////////////////

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() external {
    users = utils.createUsers(5);
    kingDeployer = users[0];
    kingLevelDeployer = users[1];
    kingSolutionDeployer = users[2];

    vm.label(kingDeployer, "kingDeployer");
    vm.label(kingLevelDeployer, "kingLevelDeployer");
    vm.label(kingSolutionDeployer, "kingSolutionDeployer");

    // King Contract //////////////////////////////////////////////////////////
    vm.prank(kingDeployer);
    king = new King();

    // King Level Contract ////////////////////////////////////////////////////
    vm.prank(kingLevelDeployer);
    kingLevel = new KingLevel();

    // King Solution Contract /////////////////////////////////////////////////
    vm.prank(kingSolutionDeployer);
    kingSolution = new KingSolution();
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_PrintAccounts() external {
    console2.log("--------------------- ACCOUNTS ------------------------");
    console2.log("kingDeployer         : ", kingDeployer);
    console2.log("kingLevelDeployer    : ", kingLevelDeployer);
    console2.log("kingSolutionDeployer : ", kingSolutionDeployer);

    console2.log("-------------------- CONTRACTS ------------------------");
    console2.log("king                 : ", address(king));
    console2.log("kingLevel            : ", address(kingLevel));
    console2.log("kingSolution         : ", address(kingSolution));
    console2.log("-------------------------------------------------------");

    assertTrue(true);
  }

  function test_02_BecomeKing() external {
    address currentKing = king._king();
    console2.log("----------------------------------------------------------");
    console2.log("currentKing", currentKing);
    console2.log("----------------------------------------------------------");

    vm.prank(kingSolutionDeployer);
    bool res = kingSolution.becomeKing(king);

    currentKing = king._king();
    console2.log("----------------------------------------------------------");
    console2.log("res", res);
    console2.log("currentKing", currentKing);
    console2.log("----------------------------------------------------------");

    vm.prank(kingLevelDeployer);
    vm.expectRevert(abi.encodeWithSelector(KingLevel.IamNotKing.selector, address(kingLevelDeployer), "I am NOT KING, Level COMPLETED"));
    kingLevel.tryKing(king);

    console2.log("----------------------------------------------------------");
    console2.log("kingLevelDeployer: ", kingLevelDeployer, "trying to become king but he gets revert, because our solution reverts in receive");
    console2.log("----------------------------------------------------------");
  }
}
