# Staking House — Execution Status

Status: execution in progress

---

## Scope

This work is scoped strictly to the Staking House.

Out of scope:
- AMM logic
- cross-house integration
- refactors or optimisations

---

## Files

- contracts/core/CityStaking.sol
- test/unit/CityStaking.t.sol

---

## Core Invariants

### 1. Monotonic Accrual
- earned rewards must never decrease
- accrual index must only move forward

### 2. Single-Use Claim
- claiming consumes earned rewards exactly once
- repeated claims without new accrual pay zero

### 3. Update Before Payout
- user accounting is updated before token transfer
- no execution window where state is stale during payout

### 4. No Stale Index Reuse
- old snapshots cannot be replayed
- claims must reference the latest accounted index

---

## Required Test Coverage (CityStaking.t.sol)

- staking increases principal
- unstaking reduces principal
- accrual increases earned rewards
- claim pays no more than earned
- second claim without new accrual pays zero
- state updated before transfer (ordering test)

---

## Completion Criteria

This work is complete when:
- all tests in CityStaking.t.sol pass
- each invariant above is directly enforced by a test
- no test relies on comments or unstated assumptions
- successful completion demonstrates invariant safety under execution

---

## Next

Proceed to AMM execution proofs.

