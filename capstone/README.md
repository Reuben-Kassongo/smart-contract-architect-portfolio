# Capstone Vault — Full-Stack Ethereum DApp

## What This Is

A complete Ethereum application built from scratch:

- Custom Solidity smart contract
- Foundry deployment pipeline
- Local blockchain (Anvil)
- React / Next.js frontend
- Wallet connection via MetaMask
- Live deposit & withdraw interaction

This project demonstrates end-to-end smart contract development and integration.

---

## What It Demonstrates

### Smart Contract Engineering
- Secure withdraw flow (Checks → Effects → Interactions pattern)
- Reentrancy-aware design
- Clear state accounting (`balanceOf`)
- Event emission for frontend tracking

### Testing & Deployment
- Deployment scripted using Foundry
- Local chain simulation with Anvil
- Manual interaction testing
- Frontend wired to live contract address

### Full-Stack Web3 Integration
- Wagmi v2 for contract reads/writes
- Viem for transaction encoding
- MetaMask wallet connection
- Real user flow: deposit → state update → withdraw

---

## How It Works

User → Connect Wallet → Deposit ETH →  
Contract updates internal balance →  
Frontend reads updated state →  
User can withdraw →  
State updates again.

Everything runs against a local blockchain node.

---

## Contract Details

Network: Local Anvil (Chain ID 31337)  
Vault Contract: 0x5FbDB2315678afecb367f032d93F642f64180aa3

---

## Why This Project Matters

This is not a tutorial clone.

It shows I can:

- Design a secure contract
- Deploy it properly
- Integrate it with a frontend
- Debug RPC issues
- Handle wallet configuration
- Connect full system flow from backend to UI

It demonstrates practical smart contract engineering — not just theory.
