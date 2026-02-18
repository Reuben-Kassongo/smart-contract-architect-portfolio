# Capstone Frontend (Next.js)

Frontend for the CapstoneVault demo: connect wallet → deposit → withdraw → verify state.

This is intentionally small and support-focused — it exists to prove end-to-end integration, not UI polish.

---

## Prereqs
- Node + pnpm (or npm)
- Local chain: **Anvil** (`chainId 31337`)
- Contract deployed locally (see `../README.md`)

---

## Run (local)
- `cd capstone/frontend`
- `pnpm i`
- `pnpm dev`
- Open: `http://localhost:3000`

---

## Required setup (MetaMask)
1. Add custom RPC: `http://127.0.0.1:8545`
2. Chain ID: `31337`
3. Import an Anvil private key into MetaMask

---

## Critical wiring (common failure)
The frontend reads the deployed contract address from:
- `lib/capstone.ts`

If you redeploy (or restart Anvil), the address changes — **update it in `lib/capstone.ts`.**

---

## Common failures (fast fixes)

### Wrong chain / address
- Symptom: calls revert or read wrong state
- Fix: MetaMask on `31337` + update `lib/capstone.ts`

### Restarted Anvil
- Symptom: balances/deployments reset
- Fix: redeploy + update address again

### Wagmi v2 provider mismatch
- Symptom: wallet connects but writes fail
- Fix: ensure `WagmiProvider` + `createConfig` + `http()` transport (see `lib/wagmi.ts`)

### Hydration / SSR mismatch
- Symptom: UI differs after refresh
- Fix: make wallet-dependent UI client-only (`'use client'`) and avoid SSR-state assumptions

---

## What this proves
- Full user flow runs against local chain
- You can debug config / wiring issues
- You verify **state**, not UI “success”
