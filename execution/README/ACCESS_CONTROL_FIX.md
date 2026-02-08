# Phase 4 — Access Control Fix

Invariant:
Only an authorized admin may mutate privileged state.

Fix:
- Admin set at construction
- All privileged functions gated by `onlyAdmin`

Result:
Invariant holds.
Authority takeover prevented.
