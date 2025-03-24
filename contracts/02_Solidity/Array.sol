// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Array {
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    //初始化长度为10的数组
    uint256[10] public myFixedSizeArr;

    function get(uint256 i) public view returns (uint256) {
        return arr[i];
    }

    function getArr() public view returns (uint256[] memory) {
        return arr;
    }
    // 添加元素
    function push(uint256 i) public {
        arr.push(i);
    }
    // 删除数组的最后一个元素
    function pop() public {
        arr.pop();
    }

    function getLength() public view returns (uint256) {
        return arr.length;
    }
    // 删除数组的某个元素
    function remove(uint256 i) public {
        delete arr[i];
    }

    function examples() external {
        uint256 x = arr[1];
        arr[1] = 123;
        // 创建一个长度为3的动态数组
        uint256[] memory a = new uint256[](3);
        a[1] = 123;
    }
}