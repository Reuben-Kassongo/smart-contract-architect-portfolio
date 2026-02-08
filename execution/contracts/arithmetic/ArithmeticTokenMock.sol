// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// Intentionally vulnerable: uses uint8 + unchecked arithmetic.
/// This is a Phase 3 proof target (overflow/underflow class).
contract ArithmeticTokenMock {
    mapping(address => uint8) public balanceOf;
    uint8 public totalSupply;

    function mint(address to, uint8 amount) external {
        unchecked {
            totalSupply += amount;      // can overflow and WRAP
            balanceOf[to] += amount;    // can overflow and WRAP
        }
    }
}
