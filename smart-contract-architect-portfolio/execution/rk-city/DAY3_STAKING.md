# Phase 3 — Day 3: Staking House

Status: IN PROGRESS

## Scope
Only the Staking House is in scope.
No AMM.
No integration.
No refactors.

---

## Files
- contracts/core/CityStaking.sol
- test/unit/CityStaking.t.sol

---

## Core invariants to prove

### 1. Monotonic Accrual
- Earned rewards must never decrease.
- Accrual index must only move forward.

### 2. Single-Use Claim
- Claim consumes earned rewards exactly once.
- Repeated claim without new accrual pays zero.

### 3. Update Before Payout
- User accounting updated before token transfer.
- No window where state is stale during payout.

### 4. No Stale Index Reuse
- Old snapshots cannot be replayed.
- Claim must reference the latest accounted index.

---

## Minimum Test Cases (CityStaking.t.sol)

- stake increases principal
- unstake reduces principal
- accrue increases earned rewards
- claim pays <= earned
- second claim without accrue pays 0
- state updated before transfer (ordering test)

---

## Completion Rule
Day 3 is complete when:
- All tests in CityStaking.t.sol are green
- Each invariant above is clearly enforced by a test
- No test relies on comments or assumptions

Next step after completion:
→ Phase 3 — Day 4: AMM
