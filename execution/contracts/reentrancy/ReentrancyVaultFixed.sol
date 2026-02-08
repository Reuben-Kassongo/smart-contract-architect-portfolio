// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReentrancyVaultFixed {
    mapping(address => uint256) public balances;
    bool private locked;

    modifier nonReentrant() {
        require(!locked, "reentrant call");
        locked = true;
        _;
        locked = false;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external nonReentrant {
        require(balances[msg.sender] >= amount, "low balance");

        // ✅ EFFECTS FIRST
        balances[msg.sender] -= amount;

        // ✅ INTERACTION LAST
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "eth transfer failed");
    }
}
