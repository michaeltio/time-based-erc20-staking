import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

export default function EmergencyWithdraw() {
  return (
    <Card className="p-6 border border-destructive/20 bg-destructive/5">
      <div className="space-y-4">
        <div>
          <h4 className="text-lg font-semibold text-foreground mb-2">
            Emergency Withdraw
          </h4>
          <p className="text-sm text-muted-foreground">
            Withdraw all tokens without claiming rewards (use with caution)
          </p>
        </div>

        <Button variant="destructive" className="w-full" size="lg">
          Emergency Withdraw All
        </Button>
      </div>
    </Card>
  );
}
