// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Immutable {
    // 不可变常量数据,在构造方法中初始化，且初始化后不可变
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}