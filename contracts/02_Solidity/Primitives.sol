// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Primitives {
    // boolean
    bool public isReady = true;

    // uint
    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123;

    // int
    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123;

    // minimum and maximum of int
    int256 public maxInt256 = type(int256).max;
    int256 public minInt256 = type(int256).min;

    // address
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // bytes
    bytes1 a = 0xb5; //  [10110101]
    bytes1 b = 0x56; //  [01010110]
    bytes public myBytes = "Hello";

    bool public defaultBool;   //false
    uint256 public defaultUint256;  //0
    int256 public defaultInt256;    //0
    address public defaultAddress;  //0X0x0000000000000000000000000000000000000000
}