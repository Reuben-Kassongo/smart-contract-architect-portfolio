# Execution — Proof

This folder contains runnable execution proofs (contracts + tests).

Invariant: a condition that must hold true across all valid executions.

Inclusion criteria:
- compiles
- runs
- demonstrates a verifiable invariant violation or guarantee

Content here is execution-only; correctness is demonstrated through code and tests.

---

## Proof 01 — Reentrancy Vault

Purpose: Demonstrate that a reentrancy flaw violates a balance invariant.

Contract:
- execution/contracts/reentrancy/ReentrancyVault.sol

Test:
- execution/tests/unit/reentrancy_invariant.t.sol

Invariant:
- vault ETH balance >= sum of recorded user balances

Run:
    forge test --match-path execution/tests/unit/reentrancy_invariant.t.sol -vv

Proof outcome:
- invariant is violated
- violation demonstrates ETH drain via reentrancy
- a failing invariant test constitutes a completed proof

