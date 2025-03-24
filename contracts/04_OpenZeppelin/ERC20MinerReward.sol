// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20MinerReward is ERC20 {
    // 日志事件
    event LogNewAlert(string description, address indexed _from, uint256 _n);

    constructor() ERC20("GoldMoney", "GM") {}

    function _reward() public {
        _mint(block.coinbase, 2000);
        emit LogNewAlert("_rewarded", block.coinbase, block.number);
    }
}
