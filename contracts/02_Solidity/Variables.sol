// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract  Variables {
    
    //stored to the blockchain
    string public test = "Hello";
    uint public num = 123;

    function doSomething() public {
        uint256 i = 456;

        //current block timestamp
        uint256 timestamp = block.timestamp;
        address sender = msg.sender;
    }
}