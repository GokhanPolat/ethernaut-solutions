// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrivacySolution {
  address private privacyContract = 0xc2C4af7424bC12b7147E72294b162B0Ab942C9e3;

  function callUnlock(bytes16 _key) external returns (bool) {
    (bool success, bytes memory data) = address(privacyContract).call(abi.encodeWithSignature("unlock(bytes16)", _key));
    require(success);
    return success;
  }
}
