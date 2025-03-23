// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Counter {
    uint256 public count;

    // function to get the current count
    function get() public view returns (uint256) {
        return count;
    }

    //function to increment count by 1
    function increment() public {
        count += 1;
    }

    //function to decrement count by 1
    function decrement() public {
        count -= 1;
    }
}