import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import ThreeNoiseBackground from "@/components/NoiseBackground";
import AsciiBackground from "@/components/ASCIIBackground";

export default function Home() {
  return (
    <div className="container mx-auto flex items-center justify-center flex-col min-h-screen ">
      {/* <ThreeNoiseBackground opacity={0.08} speed={10} /> */}
      <AsciiBackground speed={5} />
      <main className="flex  flex flex-col items-center justify-center">
        <h1 className="text-5xl font-bold text-center mb-8 text-foreground">
          Earn Rewards by Staking
        </h1>
        <p className="text-center mb-8 max-w-2xl mx-auto text-lg text-gray-100">
          Stake your tokens and earn passive income with our secure staking
          platform. Join thousands of users growing their wealth through crypto
          staking.
        </p>

        <Card className="w-full rounded-lg">
          <CardContent>
            <div className="text-center">
              <p className="text-gray-100 mb-3">Current APY</p>
              <p className="text-5xl font-bold mb-3">1577%</p>
              <p className="text-gray-100">Reward Rate: 0.5 Rewards/s</p>
            </div>
          </CardContent>
        </Card>
        <Button className="mt-8 mx-auto py-4 px-6 rounded-full">
          <Link href="/dashboard">Enter App</Link>
        </Button>
      </main>
    </div>
  );
}
