"use client";
import { useMemo } from "react";
import { useReadContract } from "wagmi";
import type { Abi } from "viem";

import { StakeTokenABI } from "@repo/contract";

export function useStakeToken(user?: `0x${string}`) {
  console.log("Address", process.env.NEXT_PUBLIC_STAKE_TOKEN_ADDRESS);
  const contract = useMemo(
    () => ({
      address: process.env.NEXT_PUBLIC_STAKE_TOKEN_ADDRESS as `0x${string}`,
      abi: StakeTokenABI as Abi,
    }),
    []
  );

  return useReadContract({
    ...contract,
    functionName: "balanceOf",
    args: user ? [user] : undefined,
    query: {
      enabled: !!user,
    },
  });
}
