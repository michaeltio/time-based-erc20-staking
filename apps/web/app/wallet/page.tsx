"use client";

import { useAccount } from "wagmi";

import { formatUnits } from "viem";
import { useERC20Balance } from "@/hooks/contracts/useRewardToken";

export default function Balance() {
  const { address, status } = useAccount();

  const { data: balance, isLoading, error } = useERC20Balance(address);

  if (!isConnected) return <p>Connect wallet dulu</p>;
  if (isLoading) return <p>Loading balance...</p>;
  if (error) return <p>Error ambil balance</p>;

  return <p>Balance: {balance ? formatUnits(balance, 18) : "0"}</p>;
}
