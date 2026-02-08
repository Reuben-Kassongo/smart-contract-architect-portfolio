# Phase 3 — Arithmetic Proof

Invariant:
Minting must never decrease total supply (supply monotonicity).

Failure:
Unchecked arithmetic + small integer type (uint8) can overflow.
When totalSupply wraps, it can *decrease* after a mint.

Proof:
Run:
forge test --match-path execution/tests/unit/arithmetic_proof.t.sol -vv

Expected result:
- Test FAILS (expected)
- Failure is the proof of exploitability.
