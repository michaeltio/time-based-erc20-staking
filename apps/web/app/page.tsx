import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import AsciiBackground from "@/components/ASCIIBackground";
import { Shield, TrendingUp, Lock } from "lucide-react";

export default function Landing() {
  return (
    <div className="min-h-screen text-foreground">
      <AsciiBackground />

      {/* Hero Section */}
      <section className="relative z-10 min-h-screen flex flex-col items-center justify-center px-4 py-20">
        <div className="max-w-3xl mx-auto text-center">
          {/* Badge
          <div className="mb-8 inline-block">
            <div className="bg-accent/10 border border-accent/20 rounded-full px-4 py-2 text-sm text-accent">
              ✓ Institutional-Grade Security
            </div>
          </div> */}
          {/* Heading */}
          <h1 className="text-5xl md:text-6xl lg:text-7xl font-bold mb-6 leading-tight text-balance">
            Earn Rewards by Staking
          </h1>
          {/* Subheading */}
          <p className="text-lg md:text-xl text-muted-foreground mb-12 leading-relaxed max-w-2xl mx-auto">
            Stake your tokens and earn passive income with our secure platform.
            Join thousands of users growing their wealth through transparent,
            professional-grade crypto staking.
          </p>
          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center mb-16">
            <Button asChild size="lg" className="rounded-full px-8">
              <Link href="/dashboard">Enter App</Link>
            </Button>
            <Button
              asChild
              variant="outline"
              size="lg"
              className="rounded-full px-8 bg-transparent"
            >
              <Link href="#learn">Learn More</Link>
            </Button>
          </div>
        </div>

        {/* Stats Card */}
        <Card className="w-full max-w-md border-border/50 bg-card/80 backdrop-blur-sm">
          <CardContent className="pt-8">
            <div className="grid grid-cols-2 gap-6 md:gap-8">
              <div className="text-center">
                <p className="text-muted-foreground text-sm mb-2">
                  Total Reward Emission
                </p>
                <p className="text-4xl md:text-5xl font-bold">0.5</p>
                <p className="text-muted-foreground text-xs">Tokens / sec</p>
              </div>
              <div className="text-center">
                <p className="text-muted-foreground text-sm mb-2">
                  Total Staked
                </p>
                <p className="text-4xl md:text-5xl font-bold">$42.5M</p>
                <p className="text-muted-foreground text-xs">
                  by the community
                </p>
              </div>
            </div>
            <p className="text-muted-foreground text-xs text-center mt-6 pt-6 border-t border-border/30">
              Distributed proportionally among all stakers
            </p>
          </CardContent>
        </Card>
      </section>
      </div>
  );
}
