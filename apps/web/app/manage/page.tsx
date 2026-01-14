"use client";

import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";

import ClientWrapper from "@/components/ClientWrapper";

import RewardEndTimeCard from "@/components/manage/RewardEndTimeCard";

interface StakerData {
  address: string;
  amount: number;
  pendingRewards: number;
  rewardDebt: number;
}

export default function ManagePage() {
  const stakers: StakerData[] = [
    {
      address: "0x1234...abcd",
      amount: 1000,
      pendingRewards: 150.75,
      rewardDebt: 50.25,
    },
    {
      address: "0x1234...abce",
      amount: 1000,
      pendingRewards: 150.75,
      rewardDebt: 50.25,
    },
    {
      address: "0x1234...abcb",
      amount: 1000,
      pendingRewards: 150.75,
      rewardDebt: 50.25,
    },
  ];

  return (
    <ClientWrapper>
      <div className="min-h-screen bg-background">
        {/* Header */}
        <header className="border-b border-border sticky top-0 z-10 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
          <div className="mx-auto max-w-7xl px-4 py-4 flex items-center justify-between">
            <div className="flex items-center gap-4">
              <h1 className="text-2xl font-bold text-foreground">
                Admin Dashboard
              </h1>
              <span className="px-3 py-1 bg-accent text-accent-foreground rounded-full text-xs font-semibold">
                OWNER
              </span>
            </div>
            <div className="flex items-center gap-4">
              <Link href="/dashboard">
                <Button variant="outline">User Dashboard</Button>
              </Link>
            </div>
          </div>
        </header>

        <main className="mx-auto max-w-7xl px-4 py-8 space-y-8">
          {/* Key Metrics */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <Card className="p-6 border border-border bg-card">
              <p className="text-sm font-medium text-muted-foreground">
                Total Staked
              </p>
              <p className="text-3xl font-bold text-foreground mt-2">5000</p>
              <p className="text-xs text-muted-foreground mt-1">5000 tokens</p>
            </Card>

            <Card className="p-6 border border-border bg-card">
              <p className="text-sm font-medium text-muted-foreground">
                Reward Rate
              </p>
              <p className="text-3xl font-bold text-foreground mt-2">0.5</p>
              <p className="text-xs text-muted-foreground mt-1">0.5/second</p>
            </Card>

            <Card className="p-6 border border-border bg-card">
              <p className="text-sm font-medium text-muted-foreground">
                Current APY
              </p>
              <p className="text-3xl font-bold text-foreground mt-2">12%</p>
              <p className="text-xs text-muted-foreground mt-1">
                Annual percentage yield
              </p>
            </Card>

            <Card className="p-6 border border-border bg-card">
              <p className="text-sm font-medium text-muted-foreground">
                Reward Balance
              </p>
              <p className="text-3xl font-bold text-foreground mt-2">5000</p>
              <p className="text-xs text-muted-foreground mt-1">5000 tokens</p>
            </Card>
          </div>

          {/* Reward Period Info */}
          <Card className="p-6 border border-border bg-card">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  Reward Ends In
                </p>
                <div className="mt-4 flex gap-4">
                  <div className="flex flex-col items-center">
                    <p className="text-2xl font-bold text-foreground">10</p>
                    <p className="text-xs text-muted-foreground">Days</p>
                  </div>
                  <div className="flex flex-col items-center">
                    <p className="text-2xl font-bold text-foreground">12</p>
                    <p className="text-xs text-muted-foreground">Hours</p>
                  </div>
                  <div className="flex flex-col items-center">
                    <p className="text-2xl font-bold text-foreground">30</p>
                    <p className="text-xs text-muted-foreground">Minutes</p>
                  </div>
                  <div className="flex flex-col items-center">
                    <p className="text-2xl font-bold text-foreground">45</p>
                    <p className="text-xs text-muted-foreground">Seconds</p>
                  </div>
                </div>
              </div>

              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  Total Users
                </p>
                <p className="text-3xl font-bold text-foreground mt-4">100</p>
                <p className="text-xs text-muted-foreground mt-2">
                  Active stakers
                </p>
              </div>

              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  Total Pending Rewards
                </p>
                <p className="text-3xl font-bold text-foreground mt-4">2500</p>
                <p className="text-xs text-muted-foreground mt-2">
                  Unclaimed rewards
                </p>
              </div>
            </div>
          </Card>

          {/* Admin Controls */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/* Update Reward Rate */}
            <Card className="p-6 border border-border bg-card">
              <h3 className="text-lg font-semibold text-foreground mb-4">
                Update Reward Rate
              </h3>
              <div className="space-y-4">
                <div>
                  <label className="text-sm font-medium text-foreground">
                    New Reward Rate (500/second)
                  </label>
                  <Input
                    type="number"
                    step="0.01"
                    placeholder="0.5"
                    className="mt-2"
                  />
                </div>
                <Button className="w-full">Update Rate</Button>
              </div>
            </Card>

            {/* Fund Rewards */}
            <Card className="p-6 border border-border bg-card">
              <h3 className="text-lg font-semibold text-foreground mb-4">
                Fund Rewards
              </h3>
              <div className="space-y-4">
                <div>
                  <label className="text-sm font-medium text-foreground">
                    Amount 5000 tokens
                  </label>
                  <Input
                    type="number"
                    step="0.01"
                    placeholder="1000"
                    className="mt-2"
                  />
                </div>
                <Button className="w-full bg-transparent" variant="outline">
                  Fund Rewards
                </Button>
              </div>
            </Card>

            {/* Update Reward End Time */}
            <RewardEndTimeCard />

            {/* Contract Info */}
            <Card className="p-6 border border-border bg-card">
              <h3 className="text-lg font-semibold text-foreground mb-4">
                Contract Info
              </h3>
              <div className="space-y-3 text-sm">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Stake Token:</span>
                  <span className="font-mono text-foreground">5000 tokens</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Reward Token:</span>
                  <span className="font-mono text-foreground">5000 tokens</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">
                    accRewardPerShare:
                  </span>
                  <span className="font-mono text-foreground">1234567890</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">
                    Last Reward Time:
                  </span>
                  <span className="font-mono text-foreground text-xs">
                    {new Date(400 * 1000).toLocaleString()}
                  </span>
                </div>
              </div>
            </Card>
          </div>

          {/* Stakers Table */}
          <Card className="p-6 border border-border bg-card">
            <h3 className="text-lg font-semibold text-foreground mb-4">
              Active Stakers
            </h3>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-border">
                    <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                      Address
                    </th>
                    <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                      Staked Amount
                    </th>
                    <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                      Pending Rewards
                    </th>
                    <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                      Reward Debt
                    </th>
                    <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                      Actions
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {stakers.map((staker) => (
                    <tr
                      key={staker.address}
                      className="border-b border-border hover:bg-muted/30"
                    >
                      <td className="py-3 px-4 text-foreground font-mono text-xs">
                        {staker.address.slice(0, 10)}...
                        {staker.address.slice(-8)}
                      </td>
                      <td className="py-3 px-4 text-right text-foreground">
                        {staker.amount.toLocaleString()}
                      </td>
                      <td className="py-3 px-4 text-right text-foreground">
                        {staker.pendingRewards.toFixed(2)}
                      </td>
                      <td className="py-3 px-4 text-right text-foreground">
                        {staker.rewardDebt.toFixed(2)}
                      </td>
                      <td className="py-3 px-4 text-right">
                        <AlertDialog>
                          <AlertDialogTrigger asChild>
                            <Button
                              size="sm"
                              variant="destructive"
                              className="text-xs"
                            >
                              Emergency Withdraw
                            </Button>
                          </AlertDialogTrigger>
                          <AlertDialogContent>
                            <AlertDialogTitle>
                              Emergency Withdraw
                            </AlertDialogTitle>
                            <AlertDialogDescription>
                              This will withdraw {staker.amount} tokens from{" "}
                              {staker.address.slice(0, 10)}...
                              {staker.address.slice(-8)} without claiming
                              pending rewards. This action cannot be undone.
                            </AlertDialogDescription>
                            <div className="flex gap-2 justify-end mt-4">
                              <AlertDialogCancel>Cancel</AlertDialogCancel>
                              <AlertDialogAction className="bg-destructive text-destructive-foreground">
                                Confirm
                              </AlertDialogAction>
                            </div>
                          </AlertDialogContent>
                        </AlertDialog>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </main>
      </div>
    </ClientWrapper>
  );
}
