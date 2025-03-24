// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Mapping {
   mapping (address => uint) public myMap;

   function getMapVal(address _addr)  public returns (uint) {
        return myMap[_addr];
   }

   function setMapVal(address _addr, uint _val) public {
        myMap[_addr] = _val;
   }

   function removeMapVal(address _addr) public {
        //删除mapping中的元素
        delete myMap[_addr];
   }
}

contract NestedMapping {
    //Mapping
    mapping (address => mapping (uint => bool)) public nestedMap;

    function getNestedMapVal(address _addr, uint _key) public view returns (bool) {
        return nestedMap[_addr][_key];
    }

    function setNestedMapVal(address _addr, uint _key, bool _val) public {
        nestedMap[_addr][_key] = _val;
    }

   function removeNestedMapVal(address _addr, uint _key) public{
        delete nestedMap[_addr][_key];
   }
}