# Smart-Contract Architect Portfolio

Invariant-driven smart-contract architecture demonstrating correctness,
security, and composability across core DeFi systems.

This portfolio proves:
- correctness via executable invariants,
- security via failure demonstrations,
- system-level reasoning via architecture and edges.

Audience: protocol engineers, smart-contract developers, and security reviewers.

---

## How to evaluate this repository

Depending on what you care about:

- **Engineering correctness** → `execution/`
- **Security reasoning** → `bug-zoo/`
- **System design & scalability** → `architecture/`

---

## Execution — Invariant-Driven Proof

This section contains **executable proofs** that core protocol invariants hold
under normal conditions — and fail under adversarial ones.

The focus is on **truth preservation**, not feature completeness.

Core properties demonstrated:
- value conservation (Token),
- accrual correctness (Staking),
- price integrity (AMM).

See:
- `execution/README.md`
- `execution/rk-city/`

---

## Architecture — City View

The system is modeled as a **city**, not a flat contract set.

Contracts are grouped into districts, with explicit edges defining
how truth flows — and how failures propagate.

See:
- `architecture/city-map.md`
- `architecture/districts.md`
- `architecture/edges.md`

---

## Security — Protocol Security Lab

Security research and exploit demonstrations live in a **separate lab**:

👉 `bug-zoo/` → links to **Protocol Security Lab**

This separation is intentional:
- this repo shows how systems are built correctly,
- the lab shows how systems fail when invariants break.

---

Status: Locked.  
This repository is intentionally not expanded beyond these cases.
