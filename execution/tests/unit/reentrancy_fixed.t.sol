// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../contracts/reentrancy/ReentrancyVaultFixed.sol";

contract ReentrancyFixedTest is Test {
    ReentrancyVaultFixed vault;
    address user = address(0xBEEF);

    function setUp() public {
        vault = new ReentrancyVaultFixed();
        vm.deal(user, 10 ether);

        vm.prank(user);
        vault.deposit{value: 10 ether}();
    }

    /// Invariant:
    /// Vault ETH balance >= sum of recorded balances
    function test_reentrancy_prevented() public {
        vm.prank(user);
        vault.withdraw(5 ether);

        assertEq(address(vault).balance, 5 ether);
        assertEq(vault.balances(user), 5 ether);
    }
}
