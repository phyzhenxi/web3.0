// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Loop{
    
    function Loop() public () {
        //for loop
        for(uint i=0; i<10; i++){
            //do something
            if(i==3){
                //skip to next iteration
                continue;
            }

            if(i==5){
                break;
            }
        }

        //while loop
        uint j=0;
        while(j<10){
            j++;
        }
    }
}