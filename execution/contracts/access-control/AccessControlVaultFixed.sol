// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AccessControlVaultFixed {
    address public admin;
    uint256 public value;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "not admin");
        _;
    }

    function setAdmin(address newAdmin) external onlyAdmin {
        admin = newAdmin;
    }

    function setValue(uint256 newValue) external onlyAdmin {
        value = newValue;
    }
}
