// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Error {
    function testRequire(uint256 _i) public pure {
        // Require 通常用于验证输入参数的合法性、检查执行函数前的条件以及验证外部合约调用的返回值等，
        // 一般应用于函数的开头 。比如验证用户输入的值是否在合理范围内，或者验证合约余额是否足够进行某项操作等。
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint256 _i) public pure {
        // Revert 适用于复杂的条件判断场景，尤其是在逻辑分支中。当需要根据多个条件或者较为复杂的逻辑来决定是否触发错误时，revert 更为合适。
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
        // Assert 用于检查内部错误和不变量，即那些不应该发生的情况 

        // Here we assert that num is always equal to 0
        // since it is impossible to update the value of num
        assert(num == 0);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}