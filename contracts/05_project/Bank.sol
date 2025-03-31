// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
/** 
 * @title 存钱罐合约
 * @author phy
 * @notice 小小银行
 */
contract Bank {

    //状态变量 immutable表示不可变
    address public immutable owner;

    //事件
    event Deposit(address _sender, uint256 amount);
    event Withdraw(uint256 amount);

    constructor() payable {
        owner = msg.sender;
    }

    //receive 函数
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdraw(address(this).balance);
        // selfdestruct是销毁当前合约
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}