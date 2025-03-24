// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Function {
    // 方法可以返回多个值
    function returnMany() public pure returns (uint256, bool, uint256) {
        return (1, true, 2);
    }

    // 返回值可以使用名称进行返回
    function named() public pure returns (uint256 x, bool b, uint256 y) {
        return (1, true, 2);
    }

    // 返回值可以使用变量进行返回
    function assigned() public pure returns (uint256 x, bool b, uint256 y) {
        x = 1;
        b = true;
        y = 2;
    }

    // 值可以解构
    function destructuringAssignments()
        public
        pure
        returns (uint256, bool, uint256, uint256, uint256)
    {
        (uint256 i, bool b, uint256 j) = returnMany();

        // 值可以解构
        (uint256 x,, uint256 y) = (4, 5, 6);

        return (i, b, j, x, y);
    }

    // 不能用map 作为出入参，但可以用数组
    function arrayInput(uint256[] memory _arr) public {}

    //数组可用于出参
    uint256[] public arr;

    function arrayOutput() public view returns (uint256[] memory) {
        return arr;
    }
}

// 调用方法可以使用键值对输入
contract XYZ {
    function someFuncWithManyInputs(
        uint256 x,
        uint256 y,
        uint256 z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint256) {}

    function callFunc() external pure returns (uint256) {
        return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
    }

    function callFuncWithKeyValue() external pure returns (uint256) {
        return someFuncWithManyInputs({
            a: address(0),
            b: true,
            c: "c",
            x: 1,
            y: 2,
            z: 3
        });
    }
}