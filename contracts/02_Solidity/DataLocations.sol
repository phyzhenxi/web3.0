// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DataLocations {
    uint[] public arr;
    mapping (uint => address) map;

     struct MyStruct {
        uint foo;
     }

     mapping (uint => MyStruct) myStructs;

     function f() public {
          _f(arr, map, myStructs[1]);

          // 从map中获取数据，存储到区块链
          MyStruct storage myStruct = myStructs[1];

          // 从map获取数据，存储到内存
          MyStruct memory myStruct2 = myStructs[0];
     }

     function _f(uint[] storage _arr, mapping (uint => address) storage _map, MyStruct storage _myStruct) internal {
          //doSomething
          _arr[0] = 123;
          _map[1] = msg.sender;
          _myStruct.foo = 123;
     }

     function g(uint[] memory _arr) public returns (uint[] memory) {
          // do something
          _arr[0] = 123;
          return _arr;
     }

     function h(uint[] calldata _arr) external {
          // do something
          _arr[0] = 123;
     }

}