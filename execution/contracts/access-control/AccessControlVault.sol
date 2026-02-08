// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AccessControlVault {
    address public admin;
    uint256 public value;

    constructor() {
        admin = msg.sender;
    }

    function setAdmin(address newAdmin) external {
        admin = newAdmin;
    }

    function setValue(uint256 newValue) external {
        require(msg.sender == admin, "not admin");
        value = newValue;
    }
}
