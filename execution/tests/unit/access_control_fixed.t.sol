// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../contracts/access-control/AccessControlVaultFixed.sol";

contract AccessControlFixedTest is Test {
    AccessControlVaultFixed vault;
    address attacker = address(0xA11CE);

    function setUp() public {
        vault = new AccessControlVaultFixed();
    }

    function test_access_control_enforced() public {
        vm.prank(attacker);
        vm.expectRevert();
        vault.setValue(999);

        assertEq(vault.value(), 0, "invariant violated");
    }
}
