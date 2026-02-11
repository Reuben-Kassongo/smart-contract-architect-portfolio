// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CapstoneVault {
    mapping(address => uint256) public balanceOf;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "ZERO");
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "ZERO");

        uint256 bal = balanceOf[msg.sender];
        require(bal >= amount, "INSUFFICIENT");

        // Checks
        balanceOf[msg.sender] = bal - amount;

        // Interaction
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "SEND_FAIL");

        emit Withdraw(msg.sender, amount);
    }
}
