#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

fail(){ echo "FAIL: $1" >&2; exit 1; }

[[ -f .env.local ]] || fail ".env.local missing. Create it first."

set -a
source .env.local
set +a

echo "PRIVATE_KEY_LENGTH=${#PRIVATE_KEY}"

[[ "${#PRIVATE_KEY}" -eq 66 ]] || fail "PRIVATE_KEY length must be 66 (0x + 64 hex)"
[[ "$PRIVATE_KEY" =~ ^0x[0-9a-fA-F]{64}$ ]] || fail "PRIVATE_KEY must be 0x + 64 hex"

[[ "$RPC_URL" =~ ^https://eth-sepolia\.g\.alchemy\.com/v2/.+ ]] || fail "RPC_URL prefix must be https://eth-sepolia.g.alchemy.com/v2/"
echo "$RPC_URL" | grep -Eq 'PASTE|YOUR|<|>|\.{3,}' && fail "RPC_URL still has placeholders"

echo "Testing RPC..."
RESP=$(curl -s -X POST "$RPC_URL" \
  -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}')

echo "$RESP"
echo "$RESP" | grep -q '"result"' || fail "RPC auth failed (key invalid / wrong endpoint)"

forge script script/capstone/DeployCapstoneVault.s.sol:DeployCapstoneVault \
  --rpc-url "$RPC_URL" --broadcast -vv
