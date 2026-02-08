// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../contracts/reentrancy/ReentrancyVault.sol";

contract ReentrancyInvariantTest is Test {
    ReentrancyVault vault;

    function setUp() public {
        vault = new ReentrancyVault();
    }

    function invariant_balance_not_drained() public {
        assert(address(vault).balance >= vault.balances(address(this)));
    }
}
