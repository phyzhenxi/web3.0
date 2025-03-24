// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ViewAndPure {
    uint256 public x = 1;

    // view 方法，只能查看，不能修改
    function addToX(uint256 y) public view returns (uint256) {
        return x + y;
    }

    // pure 方法，不能查看，不能修改
    function add(uint256 i, uint256 j) public pure returns (uint256) {
        return i + j;
    }
}