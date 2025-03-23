// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Gas {
    uint public i=0;

    //交易没有完成前，消耗所有的gas会导致交易失败
    //数据不会发生变化
    //已话费的gas不会返还
    function forever() public {
        while(true){
            i+=1;
        }
    }
}