# Reentrancy — Fix Summary

## Invariant

Vault balance must always equal the sum of recorded user balances.

---

## Fix

- state changes (effects) are applied before any external calls
- a reentrancy guard is added to prevent nested execution

---

## Result

- invariant is restored
- reentrancy-based balance drain is prevented

