# RK City — Architecture Overview

## Core Components
- CityToken (ERC20): unit of value
- CityStaking: time-based reward distribution
- CityAMM: constant product liquidity pool

## Control Layer
- CityRoles: role-based permissions
- CityEmergency: system-wide pause
- CityGuards: reentrancy + pause enforcement

## Design Principles
- Separation of concerns
- Explicit trust boundaries
- No hidden state transitions
- CEI-compliant money flows
