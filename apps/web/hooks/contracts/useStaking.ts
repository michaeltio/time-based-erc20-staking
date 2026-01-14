"use client";
import { useMemo } from "react";
import {
  useReadContract,
  useWriteContract,
  useWaitForTransactionReceipt,
} from "wagmi";
import type { Abi } from "viem";

// import { StakingABI } from "@repo/contract";
import { abi } from "@/lib/Staking.json";

export function useRewardEndTime() {
  console.log("Address", process.env.NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS);
  console.log("ABI", abi);
  const contract = useMemo(
    () => ({
      address: process.env
        .NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS as `0x${string}`,
      abi: abi as Abi,
    }),
    []
  );

  const response = useReadContract({
    ...contract,
    functionName: "rewardEndTime",
  });

  console.log("Selesai Contract");

  console.log({
    isError: response.isError,
    error: response.error,
    data: response.data,
  });

  return response;
}
