# Smart-Contract Architect Portfolio
👉 Start here: **[start-here/README.md](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/tree/main/start-here/README.md)**

Protocol-adjacent, invariant-driven portfolio showing how smart-contract correctness, security, and composability are enforced — and how they fail when invariants break.

This portfolio proves:
- correctness via executable invariants
- security via failure demonstrations
- system-level reasoning via architecture + edges

Audience: protocol teams, integration/support engineers, and security reviewers.

---

## How to evaluate this repository

Pick the path based on what you care about:

- **Integration/debugging proof** → **[start-here/](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/tree/main/start-here)**
- **Engineering correctness (executable invariants)** → **[execution/](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/tree/main/execution)**
- **Security reasoning (failures + fixes)** → **[bug-zoo/](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/tree/main/bug-zoo)**
- **System design & failure propagation** → **[architecture/](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/tree/main/architecture)**

Rule:
If an invariant is not executable **or** defended at an edge, it is considered unproven.

---

## Execution — Invariant-Driven Proof

Executable proofs that core protocol invariants hold under normal conditions — and fail under adversarial ones.

Focus: truth preservation, not feature completeness.

Core properties demonstrated:
- value conservation (Token)
- accrual correctness (Staking)
- price integrity (AMM)

See:
- **[execution/proofs/](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/tree/main/execution/proofs)**
- **[execution/rk-city/](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/tree/main/execution/rk-city)**

Run proof tests:
- `forge test -vvv --match-path "execution/tests/unit/*.t.sol"`

---

## Architecture — City View

The system is modeled as a city, not a flat contract set.

Contracts are grouped into districts, with explicit edges defining how truth flows — and how failures propagate.

See:
- **[architecture/edges.md](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/blob/main/architecture/edges.md)**

---

## Security — Bug-Zoo Pointer (Lab is separate repo)

Security exploit demonstrations live in the dedicated lab repo.
This repo contains a lightweight pointer folder for navigation.

See:
- **[bug-zoo/README.md](https://github.com/Reuben-Kassongo/smart-contract-architect-portfolio/blob/main/bug-zoo/README.md)** → links to Protocol Security Lab

Separation is intentional:
- this repo shows how systems are built correctly
- the lab shows how systems fail when invariants break

Status: Locked.
This repository is intentionally not expanded beyond these cases.
