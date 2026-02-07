# Edges — Trust & Belief Propagation

Edges describe **assumptions**, not calls.

They answer:
> “What must be true here for this contract to be safe?”

---

## Token → Everything
Assumption:
- balances and supply are correct

If false:
- AMM pricing lies
- staking rewards lie
- lending collateral lies

---

## AMM → Lending
Assumption:
- price reflects reality

If false:
- solvency checks break
- liquidations misfire

---

## Oracle → AMM / Lending / Randomness
Assumption:
- data is fresh and validated

If false:
- prices drift
- risk models collapse
- randomness becomes predictable

---

## Governance → System
Assumption:
- authority is legitimate and final

If false:
- upgrades become attacks
- emergency powers become weapons

---

## Security insight
Most exploits are **edge failures**, not local bugs.

That’s why invariants are defined first,
and code is validated against them later.
