# Arithmetic — Proof Summary

## Invariant

Minting must never decrease total supply (supply monotonicity).

---

## Failure

Unchecked arithmetic combined with a small integer type (`uint8`) allows overflow.
When `totalSupply` wraps, a mint operation can cause the recorded supply to decrease.

---

## Proof

Run:
    forge test --match-path execution/tests/unit/arithmetic_proof.t.sol -vv

---

## Result

- invariant is violated
- total supply decreases after a mint
- failing test demonstrates exploitability

