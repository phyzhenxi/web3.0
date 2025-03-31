// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//WETH 是包装 ETH 主币，作为 ERC20 的合约。
contract WETH{
    string public name = "Wrapped Ether";
    string public symbol = "WETH";
    uint8 public decimals = 18;
    event Approval(address indexed src, address indexed delegateAds, uint256 amount);
    event Transfer(address indexed src, address indexed toAds, uint256 amount);
    event Deposit(address indexed toAds, uint256 amount);
    event Withdraw(address indexed src, uint256 amount);
    

    mapping(address => uint) public balanceOf;
    // 存储每个地址的授权
    mapping(address => mapping(address => uint256)) public allowance;
    
    // 接受 ETH
    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender,  msg.value);
    }
    
    // 提款 ETH
    function withdraw(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // 查询总供应量
    function totalSupply() public view returns (uint256) {
        return address(this).balance;
    }

    // 授权
    function approve(address delegateAds, uint256 amount) public returns (bool) {
        allowance[msg.sender][delegateAds] = amount;
        emit Approval(msg.sender, delegateAds, amount);
        return true;
    }

    function transfer(address toAds, uint256 amount) public returns (bool) {
        return transferFrom(msg.sender, toAds, amount);
    }

    // 转账
    function transferFrom(address fromAds, address toAds, uint256 amount) public returns (bool) {
        require(allowance[fromAds][msg.sender] >= amount);
        if (fromAds != msg.sender) {
            require(allowance[fromAds][msg.sender] >= amount);
            allowance[fromAds][msg.sender] -= amount;
        }
        balanceOf[fromAds] -= amount;
        balanceOf[toAds] += amount;
        emit Transfer(fromAds, toAds, amount);
        return true;
    }

    // 接受 ETH
    fallback() external payable {
        deposit();
    }


    // 接受 ETH
    receive() external payable {
        deposit();
    }

}