"use client";

import { useConnection, useChainId } from "wagmi";

import { formatUnits } from "viem";
import { useRewardToken } from "@/hooks/contracts/useRewardToken";

export default function Balance() {
  const { address, status } = useConnection();
  const chainId = useChainId();

  const { data: balance, isLoading, error } = useRewardToken(address);

  if (status !== "connected") return <p>Connect wallet dulu</p>;
  if (isLoading) return <p>Loading balance...</p>;
  if (error) return <p>Error ambil balance</p>;

  return (
    <>
      <p>Chain ID: {chainId}</p>
      <p>User: {address}</p>
      <p>Balance: {balance ? formatUnits(balance as bigint, 18) : "0"}</p>
    </>
  );
}
