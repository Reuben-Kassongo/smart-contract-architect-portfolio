// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../contracts/control/MockGuardedVault.sol";

// Debug contract to expose internal constants
contract DebugMockGuardedVault is MockGuardedVault {
    constructor(address admin) MockGuardedVault(admin) {}
    
    // Expose role constants for testing
    function getOperatorRole() public pure returns (bytes32) {
        return OPERATOR_ROLE;
    }
    
    function getPauserRole() public pure returns (bytes32) {
        return PAUSER_ROLE;
    }
}

contract ControlLayerTest is Test {
    DebugMockGuardedVault vault;
    
    address ADMIN = address(0x123);
    address ALICE = address(0x456);

    function setUp() public {
        vault = new DebugMockGuardedVault(ADMIN);
    }

    function test_adminHasDefaultRoles() public view {
        bytes32 operatorRole = vault.getOperatorRole();
        bytes32 pauserRole = vault.getPauserRole();
        
        console.log("Operator role from getter:", uint256(operatorRole));
        console.log("Pauser role from getter:", uint256(pauserRole));
        
        assertTrue(vault.hasRole(vault.DEFAULT_ADMIN_ROLE(), ADMIN));
        assertTrue(vault.hasRole(operatorRole, ADMIN));
        assertTrue(vault.hasRole(pauserRole, ADMIN));
    }

    function test_onlyAdminCanGrantRoles() public {
        bytes32 operatorRole = vault.getOperatorRole();
        
        console.log("Testing with operator role:", uint256(operatorRole));
        console.log("ALICE has DEFAULT_ADMIN_ROLE?", vault.hasRole(vault.DEFAULT_ADMIN_ROLE(), ALICE));
        
        // ALICE is not admin -> must revert
        vm.startPrank(ALICE);
        vm.expectRevert();
        vault.grantRole(operatorRole, ALICE);
        vm.stopPrank();

        // ADMIN can grant
        vm.prank(ADMIN);
        vault.grantRole(operatorRole, ALICE);

        assertTrue(vault.hasRole(operatorRole, ALICE));
    }

    function test_pauseBlocksGuardedFunctions() public {
        vm.startPrank(ADMIN);

        vault.pause();
        assertTrue(vault.paused());

        vm.expectRevert();
        vault.setValue(7);

        vault.unpause();
        assertFalse(vault.paused());

        vault.setValue(7);
        assertEq(vault.value(), 7);

        vm.stopPrank();
    }

    function test_onlyOperatorCanCallOperatorFunctions() public {
        bytes32 operatorRole = vault.getOperatorRole();
        
        console.log("Operator role:", uint256(operatorRole));
        console.log("ALICE has operator role initially?", vault.hasRole(operatorRole, ALICE));
        
        // ALICE is not operator -> must revert
        vm.startPrank(ALICE);
        vm.expectRevert();
        vault.setValue(1);
        vm.stopPrank();

        // ADMIN grants operator
        vm.prank(ADMIN);
        vault.grantRole(operatorRole, ALICE);

        console.log("ALICE has operator role after grant?", vault.hasRole(operatorRole, ALICE));
        
        // ALICE can now call
        vm.prank(ALICE);
        vault.setValue(9);
        assertEq(vault.value(), 9);
    }
}
