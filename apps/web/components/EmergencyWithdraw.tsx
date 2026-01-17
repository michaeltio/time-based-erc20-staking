"use client";

import { useEffect } from "react";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { toast } from "sonner";
import { useEmergencyWithdraw } from "@/hooks/contracts/useStaking";

export default function EmergencyWithdraw() {
  const {
    emergencyWithdraw,
    isPending,
    isConfirming,
    isConfirmed,
    isError,
    error,
  } = useEmergencyWithdraw();

  const handleEmergencyWithdraw = () => {
    const confirmed = window.confirm(
      "This will withdraw all your staked tokens without rewards.\nThis action cannot be undone.\n\nAre you sure?"
    );

    if (!confirmed) {
      toast.error("Emergency withdraw cancelled.");
      return;
    }

    emergencyWithdraw();
    toast.loading("Waiting for wallet confirmation...");
  };

  useEffect(() => {
    if (isConfirmed) {
      toast.success("Emergency withdraw successful.");
    }
  }, [isConfirmed]);

  useEffect(() => {
    if (isError) {
      toast.error("Emergency withdraw failed.");
    }
  }, [isError, error]);

  return (
    <Card className="p-6 border border-destructive/30 bg-destructive/5">
      <div className="space-y-4">
        <div>
          <h4 className="text-lg font-semibold text-destructive mb-2">
            Emergency Withdraw
          </h4>
          <p className="text-sm text-muted-foreground">
            Withdraw all tokens without claiming rewards.
          </p>
        </div>

        <Button
          variant="destructive"
          className="w-full"
          size="lg"
          onClick={handleEmergencyWithdraw}
          disabled={isPending || isConfirming}
        >
          {isPending
            ? "Waiting for Wallet..."
            : isConfirming
              ? "Processing Transaction..."
              : "Emergency Withdraw All"}
        </Button>
      </div>
    </Card>
  );
}
