"use client";
import { useMemo } from "react";
import {
  useReadContract,
  useWriteContract,
  useWaitForTransactionReceipt,
} from "wagmi";
import type { Abi } from "viem";

import { StakingABI } from "@repo/contract";

export function useRewardEndTime(user?: `0x${string}`) {
  console.log("Address", process.env.NEXT_PUBLIC_STAKING_ADDRESS);
  const contract = useMemo(
    () => ({
      address: process.env.NEXT_PUBLIC_STAKING_ADDRESS as `0x${string}`,
      abi: StakingABI as Abi,
    }),
    []
  );

  return useReadContract({
    ...contract,
    functionName: "rewardEndTime",
    args: user ? [user] : undefined,
    query: {
      enabled: !!user,
    },
  });
}

export function useGetPendingReward(user?: `0x${string}`) {
  console.log("Address", process.env.NEXT_PUBLIC_STAKING_ADDRESS);
  const contract = useMemo(
    () => ({
      address: process.env.NEXT_PUBLIC_STAKING_ADDRESS as `0x${string}`,
      abi: StakingABI as Abi,
    }),
    []
  );

  return useReadContract({
    ...contract,
    functionName: "getPendingRewards",
    args: user ? [user] : undefined,
    query: {
      enabled: !!user,
    },
  });
}

export function useTotalStaked(user?: `0x${string}`) {
  console.log("Address", process.env.NEXT_PUBLIC_STAKING_ADDRESS);
  const contract = useMemo(
    () => ({
      address: process.env.NEXT_PUBLIC_STAKING_ADDRESS as `0x${string}`,
      abi: StakingABI as Abi,
    }),
    []
  );

  return useReadContract({
    ...contract,
    functionName: "totalStaked",
    args: user ? [user] : undefined,
    query: {
      enabled: !!user,
    },
  });
}

export function useGetStakeBalance(user?: `0x${string}`) {
  const contract = useMemo(
    () => ({
      address: process.env.NEXT_PUBLIC_STAKING_ADDRESS as `0x${string}`,
      abi: StakingABI as Abi,
    }),
    []
  );

  return useReadContract({
    ...contract,
    functionName: "getStakeBalance",
    args: user ? [user] : undefined,
    query: {
      enabled: !!user,
    },
  });
}

export function useStake() {
  const contract = useMemo(
    () => ({
      address: process.env.NEXT_PUBLIC_STAKING_ADDRESS as `0x${string}`,
      abi: StakingABI as Abi,
    }),
    []
  );

  const { writeContract, data: hash, isPending, error } = useWriteContract();

  const { isLoading: isConfirming, isSuccess } = useWaitForTransactionReceipt({
    hash,
  });

  async function stake(amount: bigint) {
    return writeContract({
      ...contract,
      functionName: "stake",
      args: [amount],
    });
  }

  return {
    stake,
    hash,
    isPending,
    isConfirming,
    isSuccess,
    error,
  };
}
