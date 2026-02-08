// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../contracts/access-control/AccessControlVault.sol";
import "../../contracts/access-control/AccessControlAttacker.sol";

contract AccessControlProofTest is Test {
    AccessControlVault vault;
    AccessControlAttacker attacker;

    function setUp() public {
        vault = new AccessControlVault();
        attacker = new AccessControlAttacker(vault);
    }

    function test_access_control_breaks_invariant() public {
        attacker.attack();
        assertEq(vault.value(), 0, "invariant not broken");
    }
}
