// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ArrayReplaceFromEnd {
    uint256[] public arr;

    // Remove an element from the end of the array
    function remove(uint256 index) public {
        // 复制最后一个元素到删除元素位
        arr[index] = arr[arr.length - 1];
        // 删除最后一个元素
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4];

        remove(1);
        // [1, 4, 3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        // [1, 4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}