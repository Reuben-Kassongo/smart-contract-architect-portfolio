#!/usr/bin/env bash
set -euo pipefail

# load .env.local if it exists
if [[ -f .env.local ]]; then
  set -a
  # shellcheck disable=SC1091
  source .env.local
  set +a
fi

fail() { echo "FAIL: $1" >&2; exit 1; }

# --- PRIVATE_KEY checks ---
[[ -n "${PRIVATE_KEY:-}" ]] || fail "PRIVATE_KEY is empty (set it in .env.local)"
[[ "${#PRIVATE_KEY}" -eq 66 ]] || fail "PRIVATE_KEY length must be 66 (0x + 64 hex). Got ${#PRIVATE_KEY}"
[[ "$PRIVATE_KEY" =~ ^0x[0-9a-fA-F]{64}$ ]] || fail "PRIVATE_KEY format invalid (must be 0x + 64 hex)"

# --- RPC_URL checks ---
[[ -n "${RPC_URL:-}" ]] || fail "RPC_URL is empty (set it in .env.local)"
[[ "$RPC_URL" =~ ^https://eth-sepolia\.g\.alchemy\.com/v2/.+ ]] || fail "RPC_URL must start with https://eth-sepolia.g.alchemy.com/v2/"
[[ ! "$RPC_URL" =~ PASTE|YOUR|<|> ]] || fail "RPC_URL still contains placeholders (PASTE/YOUR/< >). Replace with real key."

# --- RPC authentication check ---
echo "OK: env values look valid. Testing RPC auth..."
RESP=$(curl -s -X POST "$RPC_URL" -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' || true)

echo "$RESP" | grep -q '"result"' || fail "RPC auth failed. Response: $RESP"
echo "$RESP" | grep -qi 'aa36a7' || fail "RPC responded but not Sepolia chainId. Response: $RESP"

echo "OK: RPC authenticated + Sepolia confirmed."
