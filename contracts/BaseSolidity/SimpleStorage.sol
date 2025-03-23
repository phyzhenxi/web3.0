// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SimpleStorage {
    uint256 public number;

    //设置变量需要交gas
    function set(uint256 newNumber) public {
        number = newNumber;
    }
    //查询gas不需要交gas
    function get() public view returns (uint256) {
        return number;
    }

}