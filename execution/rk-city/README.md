## Foundry (EVM Tooling)

Foundry is used in this project to build and execute EVM smart contracts and to prove safety properties through tests.

Primary uses:
- invariant-driven testing
- execution-level proof construction
- gas measurement and local simulation

Tooling:
- Forge — Solidity testing (unit, invariant, fuzz)
- Cast — contract and chain interaction
- Anvil — local execution environment
- Chisel — Solidity REPL

---

## Documentation
https://book.getfoundry.sh/

---

## Common Commands

Build:
    forge build

Test:
    forge test

Format:
    forge fmt

Gas snapshots:
    forge snapshot

Local node:
    anvil

Deploy:
    forge script script/Counter.s.sol:CounterScript --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>

Cast:
    cast <subcommand>

Help:
    forge --help
    anvil --help
    cast --help

---

## Trust Model

### Explicit Assumptions

- an admin may pause the system
- an admin may configure reward parameters
- an admin cannot seize or redirect user funds
- user balances are fully tracked on-chain

These assumptions are explicit and auditable.
Future iterations replace the admin with multisig or on-chain governance.

---

## Scope

This repository focuses on execution and proof.
Design rationale and higher-level architecture are documented elsewhere.

