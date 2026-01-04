"use client";
import { Badge } from "@/components/ui/badge";
import { Card } from "@/components/ui/card";
import { useRewardEndTime } from "@/hooks/contracts/useStaking";

export default function StakingStatus() {
  const { data: rewardEndTimeData } = useRewardEndTime();
  console.log("Reward End Time Data:", rewardEndTimeData);
  return (
    <Card className="p-6 border border-border bg-card">
      <div className="flex items-center justify-between">
        <div>
          <p className="text-sm text-muted-foreground mb-2">Staking Status</p>
          <Badge>{"Ended"}</Badge>
        </div>
        {false && (
          <div className="text-right">
            <p className="text-xs text-muted-foreground mb-1">Ends in</p>
            <p className="font-mono text-sm text-foreground">1d 2h 30m 15s</p>
          </div>
        )}
      </div>
    </Card>
  );
}
