export const CAPSTONE_VAULT_ADDRESS = "0x5FbDB2315678afecb367f032d93F642f64180aa3" as const;

export const CAPSTONE_VAULT_ABI = [
  { type: "function", name: "balanceOf", stateMutability: "view", inputs: [{ name: "", type: "address" }], outputs: [{ name: "", type: "uint256" }] },
  { type: "function", name: "deposit", stateMutability: "payable", inputs: [], outputs: [] },
  { type: "function", name: "withdraw", stateMutability: "nonpayable", inputs: [{ name: "amount", type: "uint256" }], outputs: [] },
  { type: "event", name: "Deposit", inputs: [{ indexed: true, name: "user", type: "address" }, { indexed: false, name: "amount", type: "uint256" }], anonymous: false },
  { type: "event", name: "Withdraw", inputs: [{ indexed: true, name: "user", type: "address" }, { indexed: false, name: "amount", type: "uint256" }], anonymous: false },
] as const;
