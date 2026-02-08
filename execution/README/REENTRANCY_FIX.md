# Phase 4 — Reentrancy Fix

Invariant:
Vault balance must always match recorded balances.

Fix:
- Effects applied before external calls
- Reentrancy guard added

Result:
Invariant restored.
Reentrancy exploit prevented.
