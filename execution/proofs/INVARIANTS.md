# Protocol Invariants

The following invariants define the safety properties enforced by the system
and are validated through executable tests.

## Access Control
Only authorised roles may mutate privileged state.

## Arithmetic
Total supply must be monotonically non-decreasing.

## Reentrancy
Vault balances must match recorded user balances.

