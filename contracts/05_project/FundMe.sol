// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

//引入 预案机 chainLink 第三方服务 获取usdt价格
//预案机 chainLink 第三方服务 获取链下数据
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";



// 4. 在锁定期内，没有达到目标值，投资人可以退款
contract FundMe {
    // 2. 记录投资人并且查看
    mapping (address => uint) public fundersToAmount;

    //AggregatorV3Interface合约
    AggregatorV3Interface public dataFeed;
    // 设置最小的收款值
    uint MINIMUM_VALUE = 10 * 10 ** 18; //10 usd

    //constant 常量
    uint constant TARGET = 1000 * 10 ** 18;//1000 usd

    //设置ower
    address public owner;
    // erc20地址
    address public erc20Addr;

    //合约部署时间
    uint deploymentTimestamp;
    //合约锁定时长
    uint lockTime = 10;
    // 是否提取fund成功flag 默认为false
    bool public getFundSuccess;

    // 定义事件 提取成功
    event FundWithdrawByOwner(uint256);
    // 退款成功
    event RefundByFunder(address, uint256);
    /**
     * 构造函数
     * @param _lockTime 锁定时长
     */
    constructor(uint _lockTime,address _dataFeedAddr) {
        // 初始化 AggregatorV3Interface合约，填入ETH / USD通证地址
        dataFeed = AggregatorV3Interface(
            _dataFeedAddr
        );
        //owner初始化
        owner = msg.sender;
        //初始化部署时间
        deploymentTimestamp = block.timestamp;
        //设置锁定时长
        lockTime = _lockTime;
    }
    
    //1. 创建一个收款函数 payable 表示可以收取原生token（eth）
    function Fund() external payable{
        require(block.timestamp < deploymentTimestamp + lockTime, "window is closed");
        //参数验证，收到的eth必须大于等于1wei
        require(convertEthToUsd(msg.value) >= MINIMUM_VALUE, "Send more ETH");
        fundersToAmount[msg.sender] += msg.value;
    }

    /**
     * 将将eth转换成usdt
     * @param _ethAmount eth数量
     */
    function convertEthToUsd(uint _ethAmount) public view returns (uint) {
        // 获取最新ETH / USD价格
        uint latestEthPrice = uint(getChainlinkDataFeedLatestAnswer());
        //如何获取价格 eth数量*eth价格 = eth价值(USDT)
        // ETH / USD precision = 10 ** 8
        return _ethAmount * latestEthPrice / (10 ** 8);
    }

    /**
    * 生产商提款ether余额
    */
    function getFund() external windowClosed onlyOwner{
        // 3. 在锁定期内，达到目标值，生产商可以提款
        require(convertEthToUsd(address(this).balance)  >= TARGET,"Target not reached");
        //transfer  send 纯转账，call 转账的同时调用其他函数，或者数据处理
        //transfer 不会抛出异常，如果失败，会返回false，msg.sender只是地址，不能转账，需要强转为payable(msg.sender)
        //payable(msg.sender).transfer(address(this).balance);
        //send: send()函数返回值为bool，如果调用失败，会返回false，如果调用成功，会返回true
        //bool success = payable(msg.sender).send(address(this).balance);
        //require(success, "Failed to send Ether");
        //建议所有转账交易都使用call来进行调用,call 函数返回值是bool，如果调用失败，会返回false，如果调用成功，会返回true
        bool success;
        uint256 balance = address(this).balance;
        (success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Failed to send Ether");
        fundersToAmount[msg.sender] = 0;
        // 提取fund成功
        getFundSuccess = true;

        // emit event emit执行事件
        emit FundWithdrawByOwner(balance);
    }

    /**
     * 在锁定期内，没有达到目标值，投资人退款
     */
    function refund() external windowClosed {
        require(convertEthToUsd(address(this).balance) < TARGET, "Target is reached,cannot refund");
        require(fundersToAmount[msg.sender] > 0, "No fund to refund");
        bool success;
        uint256 balance = fundersToAmount[msg.sender];
        (success, ) = payable(msg.sender).call{value: fundersToAmount[msg.sender]}("");
        require(success, "Failed to send Ether");
        fundersToAmount[msg.sender] = 0;
        emit RefundByFunder(msg.sender, balance);
    }

    /**
     * 修改ownership
     */
    function transferOwnership(address _newOwner) external onlyOwner{
        owner = _newOwner;
    }

    /**
     * 修改funderToAmount
     *  @param _funder funder地址
     *  @param _amountToUpdate 设置的数值
     */
    function setFunderToAmount(address _funder, uint _amountToUpdate) external {
        require(msg.sender == erc20Addr,"you do not hava permission to call this function");
        fundersToAmount[_funder] = _amountToUpdate;
    }

    function setErc20Addr(address _erc20Addr) external onlyOwner{
        erc20Addr = _erc20Addr;
    }


    /**
     * 获取最新ETH / USD价格.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    /**
     * 修改器：如果是常用的语句，可以提取出来，以减少重复代码
     */
    modifier windowClosed() {
        require(block.timestamp >= deploymentTimestamp + lockTime, "windows is not closed");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "this function can Only owner called");
        _;
    }
}