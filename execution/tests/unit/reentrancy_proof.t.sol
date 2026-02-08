// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../contracts/reentrancy/ReentrancyVault.sol";
import "../../contracts/reentrancy/ReentrancyAttacker.sol";

contract ReentrancyProofTest is Test {
    ReentrancyVault vault;
    ReentrancyAttacker attacker;

    address victim = address(0xBEEF);

    function setUp() public {
        vault = new ReentrancyVault();
        attacker = new ReentrancyAttacker(vault);

        vm.deal(victim, 10 ether);
        vm.prank(victim);
        vault.deposit{value: 10 ether}();

        vm.deal(address(attacker), 1 ether);
    }

    function test_reentrancy_breaks_invariant() public {
        attacker.attack{value: 1 ether}(1 ether, 20);

        uint256 recorded =
            vault.balances(victim) + vault.balances(address(attacker));

        uint256 actual = address(vault).balance;

        assertLt(actual, recorded, "invariant not broken");
        assertGt(address(attacker).balance, 1 ether, "attacker did not profit");
    }
}
