"use client";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { toast } from "sonner";
import { useConnection } from "wagmi";
import { useTotalStaked } from "@/hooks/contracts/useStaking";
import { formatUnits } from "viem";

export default function DashboardPage() {
  const { address, status } = useConnection();
  const { data: totalStaked, isLoading, error } = useTotalStaked(address);

  return (
    <div className="min-h-screen bg-background">
      <main className="mx-auto max-w-6xl px-4 py-8">
        <h2 className="text-3xl font-bold mb-8 text-foreground">Dashboard</h2>

        {/* Statistics Section */}
        <div className="mb-12 space-y-4">
          {/* Status Banner */}
          <Card className="p-6 border border-border bg-card">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground mb-2">
                  Staking Status
                </p>
                <Badge>{"Ended"}</Badge>
              </div>
              {false && (
                <div className="text-right">
                  <p className="text-xs text-muted-foreground mb-1">Ends in</p>
                  <p className="font-mono text-sm text-foreground">
                    1d 2h 30m 15s
                  </p>
                </div>
              )}
            </div>
          </Card>

          {/* Wallet Address */}
          <Card className="p-6 border border-border bg-card">
            <p className="text-sm text-muted-foreground mb-2">Wallet Address</p>
            <p className="font-mono text-sm text-foreground break-all">
              {address || "Not connected"}
            </p>
          </Card>

          {/* Statistics Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {/* Staked Balance */}
            <Card className="p-6 border border-border bg-card">
              <p className="text-sm text-muted-foreground mb-2">
                Staked Balance
              </p>
              <p className="text-3xl font-bold text-primary">
                {totalStaked
                  ? formatUnits(totalStaked as bigint, 18)
                  : "not connected"}
              </p>
              <p className="text-xs text-muted-foreground mt-2">5 Tokens</p>
            </Card>

            {/* Pending Rewards */}
            <Card className="p-6 border border-border bg-card">
              <p className="text-sm text-muted-foreground mb-2">
                Pending Rewards
              </p>
              <p className="text-3xl font-bold text-accent">1000</p>
              <p className="text-xs text-muted-foreground mt-2">1000 Tokens</p>
            </Card>

            {/* Total Staked (Pool) */}
            <Card className="p-6 border border-border bg-card">
              <p className="text-sm text-muted-foreground mb-2">Total Staked</p>
              <p className="text-3xl font-bold text-foreground">100</p>
              <p className="text-xs text-muted-foreground mt-2">In Pool</p>
            </Card>

            {/* Reward Rate */}
            <Card className="p-6 border border-border bg-card">
              <p className="text-sm text-muted-foreground mb-2">Reward Rate</p>
              <p className="text-3xl font-bold text-foreground">0.5</p>
              <p className="text-xs text-muted-foreground mt-2">0.5 / second</p>
            </Card>
          </div>
        </div>

        {/* Actions Section */}
        <h3 className="text-xl font-semibold mb-4 text-foreground">
          Staking Actions
        </h3>
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
          {/* Stake Form */}
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
                  <Input type="number" placeholder="0.00" className="flex-1" />
                  <Button
                    type="button"
                    variant="outline"
                    className="px-4 bg-transparent"
                  >
                    Max
                  </Button>
                </div>
                <p className="text-xs text-muted-foreground">
                  Available: 10,000 Tokens
                </p>
              </div>

              <Button className="w-full" size="lg">
                "Stake"
              </Button>
            </div>
          </Card>

          {/* Withdraw Form */}
          <Card className="p-6 border border-border bg-card">
            <div className="space-y-4">
              <div>
                <h4 className="text-lg font-semibold text-foreground mb-2">
                  Withdraw Tokens
                </h4>
                <p className="text-sm text-muted-foreground">
                  Withdraw your staked tokens (claims rewards automatically)
                </p>
              </div>

              <div className="space-y-2">
                <label className="block text-sm font-medium text-foreground">
                  Amount
                </label>
                <div className="flex gap-2">
                  <Input type="number" className="flex-1" />
                  <Button
                    type="button"
                    variant="outline"
                    className="px-4 bg-transparent"
                  >
                    Max
                  </Button>
                </div>
                <p className="text-xs text-muted-foreground">
                  Staked: 5,000 Tokens
                </p>
              </div>

              <Button className="w-full" size="lg" variant="secondary">
                "Withdraw"
              </Button>
            </div>
          </Card>
        </div>

        {/* Rewards Section */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Claim Rewards */}
          <Card className="p-6 border border-border bg-card">
            <div className="space-y-4">
              <div>
                <h4 className="text-lg font-semibold text-foreground mb-2">
                  Claim Rewards
                </h4>
                <p className="text-sm text-muted-foreground">
                  Harvest your accumulated rewards
                </p>
              </div>

              <div className="flex items-end justify-between">
                <div>
                  <p className="text-xs text-muted-foreground mb-1">
                    Available to Claim
                  </p>
                  <p className="text-2xl font-bold text-accent">500</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    500 Tokens
                  </p>
                </div>
                <Button
                  size="lg"
                  className="bg-accent text-accent-foreground hover:opacity-90"
                >
                  "Claim"
                </Button>
              </div>
            </div>
          </Card>

          {/* Emergency Withdraw */}
          <Card className="p-6 border border-destructive/20 bg-destructive/5">
            <div className="space-y-4">
              <div>
                <h4 className="text-lg font-semibold text-foreground mb-2">
                  Emergency Withdraw
                </h4>
                <p className="text-sm text-muted-foreground">
                  Withdraw all tokens without claiming rewards (use with
                  caution)
                </p>
              </div>

              <Button variant="destructive" className="w-full" size="lg">
                Emergency Withdraw All
              </Button>
            </div>
          </Card>
        </div>
      </main>

      {/* Emergency Withdrawal Dialog */}
      <AlertDialog>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Emergency Withdraw</AlertDialogTitle>
            <AlertDialogDescription>
              You are about to withdraw all 0 Tokens without claiming your
              pending rewards. This action cannot be undone.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
              "Confirm Withdraw"
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
