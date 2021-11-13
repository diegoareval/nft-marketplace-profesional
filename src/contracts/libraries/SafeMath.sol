// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns(uint256){
        uint256 result = a + b;
        require(result>= a, "SafeMath adition overflow");
        return result;
    }

    function substract(uint256 a, uint256 b) internal pure returns(uint256){
        require(b<= a, "SafeMath Substraction overflow");
    uint256 result = a - b;
        return result;
    }

    function multiply(uint256 a, uint256 b) internal pure returns(uint256){
        if(a == 0){
            return 0;
        }
        uint256 result = a * b;
        require(result/a==b, "safemath: multiplication error");
        return result;
    }

    function divide(uint256 a, uint256 b) internal pure returns(uint256){
        require(b > 0, "safemath: Zero division error");
        uint256 result = a / b;
        return result;
    }

    function mod(uint256 a, uint256 b) internal pure returns(uint256){
        require(b !=0, "safemath: Zero mod error");
        uint256 result = a % b;
        return result;
    }
}