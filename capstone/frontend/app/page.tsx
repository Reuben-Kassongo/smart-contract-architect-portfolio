"use client";

import { useAccount, useConnect, useDisconnect, useReadContract, useWriteContract } from "wagmi";
import { injected } from "wagmi/connectors";
import { parseEther, formatEther } from "viem";
import { useState, useEffect } from "react";
import { CAPSTONE_VAULT_ABI, CAPSTONE_VAULT_ADDRESS } from "../lib/capstone";

export default function Page() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const { address, isConnected } = useAccount();
  const { connect } = useConnect();
  const { disconnect } = useDisconnect();
  const { writeContractAsync, isPending } = useWriteContract();

  const [depositEth, setDepositEth] = useState("0.01");
  const [withdrawEth, setWithdrawEth] = useState("0.01");

  const vaultBal = useReadContract({
    abi: CAPSTONE_VAULT_ABI,
    address: CAPSTONE_VAULT_ADDRESS,
    functionName: "balanceOf",
    args: address ? [address] : ["0x0000000000000000000000000000000000000000"],
    query: { enabled: Boolean(address) },
  });

  async function onDeposit() {
    await writeContractAsync({
      abi: CAPSTONE_VAULT_ABI,
      address: CAPSTONE_VAULT_ADDRESS,
      functionName: "deposit",
      value: parseEther(depositEth),
    });
    vaultBal.refetch();
  }

  async function onWithdraw() {
    await writeContractAsync({
      abi: CAPSTONE_VAULT_ABI,
      address: CAPSTONE_VAULT_ADDRESS,
      functionName: "withdraw",
      args: [parseEther(withdrawEth)],
    });
    vaultBal.refetch();
  }

  if (!mounted) return null;

  return (
    <main className="max-w-xl mx-auto p-6 space-y-4">
      <h1 className="text-2xl font-bold">Capstone Vault</h1>

      {!isConnected ? (
        <button className="px-4 py-2 rounded-lg border" onClick={() => connect({ connector: injected() })}>
          Connect Wallet
        </button>
      ) : (
        <div className="space-y-4">
          <div className="p-3 rounded-lg border">
            Connected: {address}
          </div>

          <div>
            Vault Balance: {vaultBal.data ? formatEther(vaultBal.data) : "0"} ETH
          </div>

          <div>
            <input
              className="border p-2 text-black"
              value={depositEth}
              onChange={(e) => setDepositEth(e.target.value)}
            />
            <button className="border p-2 ml-2" disabled={isPending} onClick={onDeposit}>
              Deposit
            </button>
          </div>

          <div>
            <input
              className="border p-2 text-black"
              value={withdrawEth}
              onChange={(e) => setWithdrawEth(e.target.value)}
            />
            <button className="border p-2 ml-2" disabled={isPending} onClick={onWithdraw}>
              Withdraw
            </button>
          </div>
        </div>
      )}
    </main>
  );
}
