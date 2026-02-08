// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../contracts/arithmetic/ArithmeticTokenMock.sol";

contract ArithmeticProofTest is Test {
    ArithmeticTokenMock token;
    address attacker = address(0xA11CE);

    function setUp() public {
        token = new ArithmeticTokenMock();
    }

    /// Invariant (Supply Monotonicity):
    /// Minting must never DECREASE totalSupply.
    function test_arithmetic_overflow_breaks_supply_monotonicity() public {
        token.mint(attacker, 250);
        uint256 beforeSupply = token.totalSupply();

        token.mint(attacker, 10); // 250 + 10 = 260 -> wraps to 4 in uint8

        uint256 afterSupply = token.totalSupply();

        assertGe(afterSupply, beforeSupply, "invariant not broken");
    }
}
