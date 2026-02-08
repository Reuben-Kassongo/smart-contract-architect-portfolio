# Execution (Phase 3 — Proof)

This folder contains runnable proofs (contracts + tests).

Rule: Phase 3 only grows when real proof exists:
- compiles
- runs
- produces a verifiable result

## Proof 01 — Reentrancy Vault

Contract:
- execution/contracts/reentrancy/ReentrancyVault.sol

Test:
- execution/tests/unit/reentrancy_invariant.t.sol

Invariant (truth):
- vault ETH balance >= recorded balances

Run:
forge test --match-path execution/tests/unit/reentrancy_invariant.t.sol -vv

Next (Step 3):
- add attacker/handler so the invariant FAILS (proves drain).
