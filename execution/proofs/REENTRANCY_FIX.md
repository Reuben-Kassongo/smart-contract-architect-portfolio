# Reentrancy — Fix Summary

## Invariant

Vault balance must always match the sum of recorded user balances.

---

## Fix

- state updates (effects) are applied before external calls
- a reentrancy guard is added to prevent nested execution

---

## Result

- invariant is restored under execution
- reentrancy-based balance manipulation is prevented
- vault state remains consistent across calls

