# Arithmetic — Proof

## Invariant

Total supply must be monotonically non-decreasing under mint operations.

---

## Violation Mechanism

Unchecked arithmetic combined with a small integer type (`uint8`) can overflow.

When `totalSupply` wraps, a subsequent mint operation causes the recorded supply to decrease, directly violating the invariant.

---

## Proof

Run:
    forge test --match-path execution/tests/unit/arithmetic_proof.t.sol -vv

---

## Proof Outcome

- invariant check fails as expected
- failure demonstrates a supply monotonicity violation
- arithmetic overflow renders the mint logic exploitable

