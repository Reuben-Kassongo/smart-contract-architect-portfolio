# Access Control — Fix Summary

## Invariant

Only an authorised admin may mutate privileged state.

---

## Fix

- admin is set at construction
- all privileged functions are gated by `onlyAdmin`

---

## Result

- invariant is enforced
- unauthorised state mutation is prevented
- authority takeover is not possible

