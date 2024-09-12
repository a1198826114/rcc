// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24; //声明版本

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract Lock {
    bytes1 public a=0xb5;
    uint public unlockTime;
    address payable public owner;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        //  a = 0xb5;
        console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp,uint8(a));
    
        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
