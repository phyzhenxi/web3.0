// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MultisigWallet {
   
    // 交易信息
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
    }

    // ower
    address[] public owners;

    mapping (address => bool) public isOwner;

    uint public required;
    
    Transaction[] public transactions;

    mapping (uint => mapping (address => bool)) public approved;

    // 事件
    event Deposit(address indexed sender, uint256 amount);
    event Submit(uint256 indexed txId);
    event Approve(address indexed owner, uint256 indexed txId);
    event Revoke(address indexed owner, uint256 indexed txId);
    event Execute(uint256 indexed txId);

    // receive
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender],"not owner");
        _;
    }

    modifier txExists(uint256 _txId) {
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    modifier notApproved(uint256 _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    modifier notExecuted(uint256 _txId) {
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "owners required");
        require(_required > 0 && _required <= _owners.length, "invalid required number of owners");
        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique");

            isOwner[owner] =true;
            owners.push(owner);
        }
    }


    function getBalance() external view  returns (uint256 balance) {
        return address(this).balance;
    }

    function submit(address _to, uint _value, bytes memory _data) external onlyOwner returns(uint256 txId) {
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false
        }));
        emit Submit(transactions.length - 1);
        return transactions.length - 1;
    }

    function approve(uint256 _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function execute(uint256 _txId) external txExists(_txId) notExecuted(_txId) {
        require(getApprovalCount(_txId)>=required,"approvals < required");
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;
        (bool success, ) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "tx failed");
        emit Execute(_txId);
    }

    function getApprovalCount(uint256 _txId) public view returns (uint256 count) {
        for (uint i = 0; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                count += 1;
            }
        }
    }
    function revoke(uint256 _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }

}