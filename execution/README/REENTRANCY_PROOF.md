# Phase 3 — Reentrancy Proof

## What this proves

This test demonstrates a real reentrancy exploit that violates a core invariant.

The contract performs an external call before state is finalized, allowing
an attacker to repeatedly withdraw funds.

The invariant fails under execution.

---

## Invariant

The ETH balance held by the vault must always be greater than or equal to
the sum of recorded user balances.

---

## Failure

During reentrancy:
- The attacker re-enters `withdraw`
- State has not been updated yet
- Funds are withdrawn multiple times
- Recorded balances diverge from reality

The invariant is broken.

---

## Proof

Test file:
execution/tests/unit/reentrancy_proof.t.sol

Result:
- Test FAILS
- Failure is EXPECTED
- Failure is the proof of exploitability

---

## Why this matters

This mirrors real protocol exploits where:
- State is trusted too early
- External calls are unsafe
- Value escapes before finality

This is a canonical protocol failure pattern.
