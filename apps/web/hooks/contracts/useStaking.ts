"use client";

import { useMemo } from "react";
import {
  useReadContract,
  useWriteContract,
  useWaitForTransactionReceipt,
} from "wagmi";
import type { Abi } from "viem";

import { StakingABI } from "@repo/contract";

export function useRewardEndTime() {
  return useReadContract({
    address: process.env.NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS as `0x${string}`,
    abi: StakingABI as Abi,
    functionName: "rewardEndTime",
  });
}

export function useStakedBalance(user?: `0x${string}`) {
  return useReadContract({
    address: process.env.NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS as `0x${string}`,
    abi: StakingABI as Abi,
    functionName: "getStakedBalance",
    args: user ? [user] : undefined,
    query: {
      enabled: !!user,
    },
  });
}

export function usePendingRewards(user?: `0x${string}`) {
  return useReadContract({
    address: process.env.NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS as `0x${string}`,
    abi: StakingABI as Abi,
    functionName: "getPendingRewards",
    args: user ? [user] : undefined,
    query: {
      enabled: !!user,
    },
  });
}

export function useTotalStaked() {
  return useReadContract({
    address: process.env.NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS as `0x${string}`,
    abi: StakingABI as Abi,
    functionName: "totalStaked",
  });
}

export function useRewardRate() {
  return useReadContract({
    address: process.env.NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS as `0x${string}`,
    abi: StakingABI as Abi,
    functionName: "rewardRate",
  });
}

export function useStake(amount: bigint) {
  const writeContract = useWriteContract();

  writeContract.mutate({
    address: process.env.NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS as `0x${string}`,
    abi: StakingABI as Abi,
    functionName: "stake",
    args: [amount],
  });
}
