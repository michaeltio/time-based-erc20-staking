"use client";

import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { useState, useEffect } from "react";
import { useStake } from "@/hooks/contracts/useStaking";
import {
  useBalanceOf,
  useAllowance,
  useApprove,
} from "@/hooks/contracts/useStakeToken";
import { useConnection } from "wagmi";
import { formatUnits, parseEther } from "viem";

export default function StakeCard() {
  const [amount, setAmount] = useState("");
  const { address } = useConnection();
  const { data: balance } = useBalanceOf(address);
  const { data: allowance } = useAllowance(
    address,
    process.env.NEXT_PUBLIC_STAKE_TOKEN_ADDRESS as `0x${string}`
  );
  const {
    stake,
    isPending: isStakePending,
    isConfirming: isStakeConfirming,
    isConfirmed: isStakeConfirmed,
    isError: isStakeError,
  } = useStake();

  const {
    approve,
    isPending: isApprovePending,
    isConfirming: isApproveConfirming,
    isConfirmed: isApproveConfirmed,
    isError: isApproveError,
  } = useApprove();

  const allowanceValue = allowance as bigint | undefined;

  const handleStake = () => {
    console.log("Amount Entered: ", amount);
    if (!amount) return;

    if (allowanceValue! < parseEther(amount)) {
      console.log("Insufficient allowance. Please approve tokens first.");
      approve(
        process.env.NEXT_PUBLIC_STAKING_CONTRACT_ADDRESS as `0x${string}`,
        parseEther(amount)
      );
      return;
    }

    stake(parseEther(amount));
  };

  useEffect(() => {
    console.log("triggered Confirming Stake")
    if (!amount) return;
    if (!isApproveConfirmed) return;
    if (allowanceValue === undefined) return;

    const amountWei = parseEther(amount);

    if (allowanceValue >= amountWei) {
      stake(amountWei);
    }
  }, [isApproveConfirmed, allowanceValue]);

  useEffect(() => {
    if (isStakeConfirmed) {
      console.log("Stake confirmed!");
    }

    if (isStakePending) {
      console.log("Stake pending...");
    }

    if (isStakeError) {
      console.log("Stake error occurred.");
    }

    if (isStakeConfirming) {
      console.log("Stake confirming...");
    }
  }, [isStakeConfirmed, isStakePending, isStakeError, isStakeConfirming]);

  const rawBalance = balance as bigint | undefined;

  return (
    <Card className="p-6 border border-border bg-card">
      <div className="space-y-4">
        <div>
          <h4 className="text-lg font-semibold text-foreground mb-2">
            Stake Tokens
          </h4>
          <p className="text-sm text-muted-foreground">
            Lock your tokens to earn rewards
          </p>
        </div>

        <div className="space-y-2">
          <label className="block text-sm font-medium text-foreground">
            Amount
          </label>
          <div className="flex gap-2">
            <Input
              type="number"
              placeholder="0.00"
              className="flex-1"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
            />
            <Button
              type="button"
              variant="outline"
              className="px-4 bg-transparent"
            >
              Max
            </Button>
          </div>
          <p className="text-xs text-muted-foreground">
            Available: {formatUnits(rawBalance ?? 0n, 18)} Tokens
          </p>
        </div>

        <Button className="w-full" size="lg" onClick={handleStake}>
          Stake
        </Button>
      </div>
    </Card>
  );
}
