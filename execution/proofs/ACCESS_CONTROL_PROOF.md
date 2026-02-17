# Access Control — Proof

## Invariant

Only an authorised admin may mutate privileged state.

---

## Enforcement

- admin address is set at construction
- all privileged state-changing functions are gated by `onlyAdmin`

---

## Proof Outcome

- unauthorised callers cannot mutate privileged state
- authority takeover is prevented
- invariant is enforced under execution

