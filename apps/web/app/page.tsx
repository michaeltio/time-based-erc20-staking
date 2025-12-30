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

      {/* Features Section */}
      <section
        id="learn"
        className="relative z-10 py-20 px-4 bg-gradient-to-b from-transparent via-accent/5 to-transparent"
      >
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-bold mb-4 text-balance">
              Why Choose Us
            </h2>
            <p className="text-muted-foreground text-lg max-w-2xl mx-auto">
              Built with institutional standards and designed for your peace of
              mind.
            </p>
          </div>

          <div className="grid md:grid-cols-3 gap-8">
            {/* Feature 1 */}
            <div className="group p-8 rounded-2xl bg-card/40 border border-border/50 backdrop-blur-sm hover:border-accent/30 transition-all">
              <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center mb-6 group-hover:bg-primary/20 transition-colors">
                <Lock className="w-6 h-6 text-primary" />
              </div>
              <h3 className="text-xl font-bold mb-3">Bank-Grade Security</h3>
              <p className="text-muted-foreground text-sm leading-relaxed">
                Military-grade encryption and multi-signature wallets protect
                your assets 24/7.
              </p>
            </div>

            {/* Feature 2 */}
            <div className="group p-8 rounded-2xl bg-card/40 border border-border/50 backdrop-blur-sm hover:border-accent/30 transition-all">
              <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center mb-6 group-hover:bg-primary/20 transition-colors">
                <TrendingUp className="w-6 h-6 text-primary" />
              </div>
              <h3 className="text-xl font-bold mb-3">Transparent Returns</h3>
              <p className="text-muted-foreground text-sm leading-relaxed">
                Real-time reward tracking and detailed analytics on your
                earnings.
              </p>
            </div>

            {/* Feature 3 */}
            <div className="group p-8 rounded-2xl bg-card/40 border border-border/50 backdrop-blur-sm hover:border-accent/30 transition-all">
              <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center mb-6 group-hover:bg-primary/20 transition-colors">
                <Shield className="w-6 h-6 text-primary" />
              </div>
              <h3 className="text-xl font-bold mb-3">Professional Support</h3>
              <p className="text-muted-foreground text-sm leading-relaxed">
                24/7 institutional-grade support from our expert team.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="relative z-10 border-t border-border/30 py-12 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="grid md:grid-cols-4 gap-8 mb-8">
            <div>
              <h4 className="font-bold mb-4">StakeVault</h4>
              <p className="text-muted-foreground text-sm">
                Professional crypto staking platform.
              </p>
            </div>
            <div>
              <h4 className="font-semibold text-sm mb-4 uppercase tracking-wider">
                Product
              </h4>
              <ul className="space-y-2 text-sm text-muted-foreground">
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    Features
                  </Link>
                </li>
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    Security
                  </Link>
                </li>
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    Pricing
                  </Link>
                </li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold text-sm mb-4 uppercase tracking-wider">
                Company
              </h4>
              <ul className="space-y-2 text-sm text-muted-foreground">
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    About
                  </Link>
                </li>
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    Blog
                  </Link>
                </li>
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    Careers
                  </Link>
                </li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold text-sm mb-4 uppercase tracking-wider">
                Legal
              </h4>
              <ul className="space-y-2 text-sm text-muted-foreground">
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    Terms
                  </Link>
                </li>
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    Privacy
                  </Link>
                </li>
                <li>
                  <Link
                    href="#"
                    className="hover:text-foreground transition-colors"
                  >
                    Contact
                  </Link>
                </li>
              </ul>
            </div>
          </div>
          <div className="border-t border-border/30 pt-8 flex flex-col md:flex-row justify-between items-center text-sm text-muted-foreground">
            <p>&copy; 2025 StakeVault. All rights reserved.</p>
            <div className="flex gap-6 mt-4 md:mt-0">
              <Link
                href="#"
                className="hover:text-foreground transition-colors"
              >
                Twitter
              </Link>
              <Link
                href="#"
                className="hover:text-foreground transition-colors"
              >
                Discord
              </Link>
              <Link
                href="#"
                className="hover:text-foreground transition-colors"
              >
                GitHub
              </Link>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
