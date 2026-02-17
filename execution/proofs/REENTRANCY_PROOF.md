# Reentrancy — Proof

## What This Demonstrates

This test demonstrates a concrete reentrancy exploit that violates a core balance invariant.

The contract performs an external call before state is finalised, allowing an attacker to re-enter execution and withdraw funds multiple times.

The invariant fails under real execution.

---

## Invariant

The ETH balance held by the vault must always be greater than or equal to the sum of recorded user balances.

---

## Violation

During reentrancy:
- the attacker re-enters `withdraw`
- user state has not yet been updated
- funds are withdrawn multiple times
- recorded balances diverge from actual ETH held

The invariant is violated.

---

## Proof

Test file:
    execution/tests/unit/reentrancy_proof.t.sol

Execution result:
- test fails
- failure is expected
- failure constitutes proof of exploitability

---

## Why This Matters

This mirrors real-world protocol failures where:
- state is trusted before finalisation
- external calls are unsafe
- value escapes prior to invariant enforcement

This is a canonical reentrancy failure pattern.

