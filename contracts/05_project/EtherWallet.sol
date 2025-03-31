// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EtherWallet {
    // 确认钱包所有者
    address payable public immutable owner;

    event Log(string _funName,address _from,uint _value);

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {
        emit Log("deposit",msg.sender,msg.value);
    }

    function withdraw(uint _amount) external {
        require(msg.sender == owner,"only owner can call this function");
        require(_amount <= address(this).balance,"insufficient balance");
        emit Log("withdraw",msg.sender,_amount);
        // owner.transfer 相比 msg.sender 更消耗Gas
        payable(msg.sender).transfer(_amount);
    }

    function withdraw2(uint _amount) external{
        require(msg.sender == owner,"only owner can call this function");
        bool success = payable(msg.sender).send(_amount);
        require(success,"send failed");
    }

    function withdraw3() external {
        require(msg.sender == owner,"only owner can call this function");
        (bool success,) = payable(msg.sender).call{value:address(this).balance}("");
        require(success,"call failed");
    }

    function getBalance() external view returns(uint){
        return address(this).balance;
    }

}