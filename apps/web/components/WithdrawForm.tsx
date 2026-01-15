import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

export default function WithdrawForm() {
  return (
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
          <p className="text-xs text-muted-foreground">Staked: 5,000 Tokens</p>
        </div>

        <Button className="w-full" size="lg" variant="secondary">
          "Withdraw"
        </Button>
      </div>
    </Card>
  );
}
