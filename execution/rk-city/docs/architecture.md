# RK City — Architecture Overview

## Core Components

The protocol is composed of the following core primitives:

- **CityToken (ERC20)** — unit of value and accounting base
- **CityStaking** — time-based reward accrual and distribution
- **CityAMM** — constant-product liquidity pool for price discovery

---

## Control Layer

System-wide control and safety mechanisms are isolated into a dedicated control layer:

- **CityRoles** — role-based access and permission management
- **CityEmergency** — global pause and recovery controls
- **CityGuards** — enforcement of reentrancy protection and pause checks

---

## Design Principles

The system is built around the following architectural principles:

- clear separation of concerns across contracts
- explicit and auditable trust boundaries
- no hidden or implicit state transitions
- CEI-compliant value flows and external interactions

