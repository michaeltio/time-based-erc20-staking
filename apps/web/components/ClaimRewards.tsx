import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

export default function ClaimRewards() {
  return (
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
            <p className="text-xs text-muted-foreground mt-1">500 Tokens</p>
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
  );
}
