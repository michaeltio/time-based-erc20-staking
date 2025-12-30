// "use client";

// import { useEffect, useState } from "react";
// import Link from "next/link";
// import { Button } from "@/components/ui/button";
// import { Card } from "@/components/ui/card";
// import { Input } from "@/components/ui/input";
// import { Badge } from "@/components/ui/badge";
// import {
//   AlertDialog,
//   AlertDialogAction,
//   AlertDialogCancel,
//   AlertDialogContent,
//   AlertDialogDescription,
//   AlertDialogFooter,
//   AlertDialogHeader,
//   AlertDialogTitle,
// } from "@/components/ui/alert-dialog";
// import { MOCK_STAKING_DATA } from "@/lib/mock-staking-data";
// import { toast } from "sonner";

// export default function DashboardPage() {
//   // Countdown timer
//   const [countdown, setCountdown] = useState({
//     days: 0,
//     hours: 0,
//     minutes: 0,
//     seconds: 0,
//   });

//   // useEffect(() => {
//   //   const timer = setInterval(() => {
//   //     setCountdown(formatCountdown(MOCK_STAKING_DATA.rewardEndTime));
//   //   }, 1000);
//   //   return () => clearInterval(timer);
//   // }, []);

//   // Stake form state
//   const [stakeAmount, setStakeAmount] = useState("");
//   const [stakeLoading, setStakeLoading] = useState(false);

//   const handleStake = async () => {
//     const amount = Number.parseFloat(stakeAmount);

//     if (!stakeAmount || isNaN(amount) || amount <= 0) {
//       toast.error("Invalid Amount", {
//         description: "Please enter a valid amount greater than 0",
//       });
//       return;
//     }

//     if (!isActive) {
//       toast.error("Staking Ended", {
//         description: "The staking period has ended. You cannot stake anymore.",
//       });
//       return;
//     }

//     setStakeLoading(true);
//     setTimeout(() => {
//       stake(amount);
//       setStakeAmount("");
//       setStakeLoading(false);
//       toast({
//         title: "Staking Successful",
//         description: `Successfully staked ${amount} ${MOCK_STAKING_DATA.stakeToken}`,
//       });
//     }, 800);
//   };

//   // Withdraw form state
//   const [withdrawAmount, setWithdrawAmount] = useState("");
//   const [withdrawLoading, setWithdrawLoading] = useState(false);

//   const handleWithdraw = async () => {
//     const amount = Number.parseFloat(withdrawAmount);
//     const stakedAmount = state?.user.amount || 0;

//     if (!withdrawAmount || isNaN(amount) || amount <= 0) {
//       toast({
//         title: "Invalid Amount",
//         description: "Please enter a valid amount greater than 0",
//         variant: "destructive",
//       });
//       return;
//     }

//     if (amount > stakedAmount) {
//       toast({
//         title: "Insufficient Balance",
//         description: `You can only withdraw up to ${stakedAmount} ${MOCK_STAKING_DATA.stakeToken}`,
//         variant: "destructive",
//       });
//       return;
//     }

//     setWithdrawLoading(true);
//     setTimeout(() => {
//       withdraw(amount);
//       setWithdrawAmount("");
//       setWithdrawLoading(false);
//       toast({
//         title: "Withdrawal Successful",
//         description: `Successfully withdrew ${amount} ${MOCK_STAKING_DATA.stakeToken}. Rewards claimed automatically.`,
//       });
//     }, 800);
//   };

//   // Claim rewards
//   const [claimLoading, setClaimLoading] = useState(false);

//   const handleClaim = async () => {
//     if (pendingRewards <= 0) {
//       toast({
//         title: "No Rewards",
//         description: "You have no pending rewards to claim",
//         variant: "destructive",
//       });
//       return;
//     }

//     setClaimLoading(true);
//     setTimeout(() => {
//       claimRewards();
//       setClaimLoading(false);
//       toast({
//         title: "Rewards Claimed",
//         description: `Successfully claimed ${pendingRewards.toFixed(4)} ${MOCK_STAKING_DATA.rewardToken}`,
//       });
//     }, 800);
//   };

//   // Emergency withdraw
//   const [emergencyOpen, setEmergencyOpen] = useState(false);
//   const [emergencyLoading, setEmergencyLoading] = useState(false);

//   const handleEmergencyWithdraw = async () => {
//     const stakedAmount = state?.user.amount || 0;
//     setEmergencyLoading(true);
//     setTimeout(() => {
//       emergencyWithdraw();
//       setEmergencyLoading(false);
//       setEmergencyOpen(false);
//       toast({
//         title: "Emergency Withdrawal Complete",
//         description: `Successfully withdrew all ${stakedAmount} ${MOCK_STAKING_DATA.stakeToken}. Rewards were not claimed.`,
//         variant: "destructive",
//       });
//     }, 800);
//   };

//   if (isLoading) {
//     return (
//       <div className="min-h-screen bg-background">
//         {/* Header */}
//         <header className="border-b border-border bg-card">
//           <div className="mx-auto max-w-6xl px-4 py-4 flex items-center justify-between">
//             <Link href="/">
//               <h1 className="text-2xl font-bold text-foreground hover:opacity-80 transition-opacity">
//                 Crypto Staking
//               </h1>
//             </Link>
//             <Button
//               variant="outline"
//               size="icon"
//               disabled
//               className="rounded-full bg-transparent"
//             />
//           </div>
//         </header>

//         <main className="mx-auto max-w-6xl px-4 py-8">
//           <div className="text-center text-muted-foreground">
//             Loading staking data...
//           </div>
//         </main>
//       </div>
//     );
//   }

//   const stakedAmount = state?.user.amount || 0;

//   return (
//     <div className="min-h-screen bg-background">
//       <header className="border-b border-border bg-card">
//         <div className="mx-auto max-w-6xl px-4 py-4 flex items-center justify-between">
//           <Link href="/">
//             <h1 className="text-2xl font-bold text-foreground hover:opacity-80 transition-opacity">
//               Crypto Staking
//             </h1>
//           </Link>
//         </div>
//       </header>

//       <main className="mx-auto max-w-6xl px-4 py-8">
//         <h2 className="text-3xl font-bold mb-8 text-foreground">Dashboard</h2>

//         {/* Statistics Section */}
//         <div className="mb-12 space-y-4">
//           {/* Status Banner */}
//           <Card className="p-6 border border-border bg-card">
//             <div className="flex items-center justify-between">
//               <div>
//                 <p className="text-sm text-muted-foreground mb-2">
//                   Staking Status
//                 </p>
//                 <Badge variant={isActive ? "default" : "secondary"}>
//                   {isActive ? "Active" : "Ended"}
//                 </Badge>
//               </div>
//               {isActive && (
//                 <div className="text-right">
//                   <p className="text-xs text-muted-foreground mb-1">Ends in</p>
//                   <p className="font-mono text-sm text-foreground">
//                     {countdown.days}d {countdown.hours}h {countdown.minutes}m{" "}
//                     {countdown.seconds}s
//                   </p>
//                 </div>
//               )}
//             </div>
//           </Card>

//           {/* Wallet Address */}
//           <Card className="p-6 border border-border bg-card">
//             <p className="text-sm text-muted-foreground mb-2">Wallet Address</p>
//             <p className="font-mono text-sm text-foreground break-all">
//               {state?.user.address}
//             </p>
//           </Card>

//           {/* Statistics Grid */}
//           <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
//             {/* Staked Balance */}
//             <Card className="p-6 border border-border bg-card">
//               <p className="text-sm text-muted-foreground mb-2">
//                 Staked Balance
//               </p>
//               <p className="text-3xl font-bold text-primary">
//                 {state?.user.amount.toLocaleString(undefined, {
//                   maximumFractionDigits: 2,
//                 })}
//               </p>
//               <p className="text-xs text-muted-foreground mt-2">
//                 {MOCK_STAKING_DATA.stakeToken} Tokens
//               </p>
//             </Card>

//             {/* Pending Rewards */}
//             <Card className="p-6 border border-border bg-card">
//               <p className="text-sm text-muted-foreground mb-2">
//                 Pending Rewards
//               </p>
//               <p className="text-3xl font-bold text-accent">
//                 {pendingRewards.toLocaleString(undefined, {
//                   maximumFractionDigits: 4,
//                 })}
//               </p>
//               <p className="text-xs text-muted-foreground mt-2">
//                 {MOCK_STAKING_DATA.rewardToken} Tokens
//               </p>
//             </Card>

//             {/* Total Staked (Pool) */}
//             <Card className="p-6 border border-border bg-card">
//               <p className="text-sm text-muted-foreground mb-2">Total Staked</p>
//               <p className="text-3xl font-bold text-foreground">
//                 {state?.totalStaked.toLocaleString(undefined, {
//                   maximumFractionDigits: 0,
//                 })}
//               </p>
//               <p className="text-xs text-muted-foreground mt-2">In Pool</p>
//             </Card>

//             {/* Reward Rate */}
//             <Card className="p-6 border border-border bg-card">
//               <p className="text-sm text-muted-foreground mb-2">Reward Rate</p>
//               <p className="text-3xl font-bold text-foreground">
//                 {MOCK_STAKING_DATA.rewardRate}
//               </p>
//               <p className="text-xs text-muted-foreground mt-2">
//                 {MOCK_STAKING_DATA.rewardToken} / second
//               </p>
//             </Card>
//           </div>
//         </div>

//         {/* Actions Section */}
//         <h3 className="text-xl font-semibold mb-4 text-foreground">
//           Staking Actions
//         </h3>
//         <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
//           {/* Stake Form */}
//           <Card className="p-6 border border-border bg-card">
//             <div className="space-y-4">
//               <div>
//                 <h4 className="text-lg font-semibold text-foreground mb-2">
//                   Stake Tokens
//                 </h4>
//                 <p className="text-sm text-muted-foreground">
//                   Lock your tokens to earn rewards
//                 </p>
//               </div>

//               <div className="space-y-2">
//                 <label className="block text-sm font-medium text-foreground">
//                   Amount
//                 </label>
//                 <div className="flex gap-2">
//                   <Input
//                     type="number"
//                     placeholder="0.00"
//                     value={stakeAmount}
//                     onChange={(e) => setStakeAmount(e.target.value)}
//                     disabled={stakeLoading || !isActive}
//                     className="flex-1"
//                   />
//                   <Button
//                     type="button"
//                     variant="outline"
//                     onClick={() => setStakeAmount("10000")}
//                     disabled={stakeLoading || !isActive}
//                     className="px-4 bg-transparent"
//                   >
//                     Max
//                   </Button>
//                 </div>
//                 <p className="text-xs text-muted-foreground">
//                   Available: 10,000 {MOCK_STAKING_DATA.stakeToken}
//                 </p>
//               </div>

//               <Button
//                 onClick={handleStake}
//                 disabled={stakeLoading || !isActive || !stakeAmount}
//                 className="w-full"
//                 size="lg"
//               >
//                 {stakeLoading ? "Processing..." : "Stake"}
//               </Button>

//               {!isActive && (
//                 <p className="text-xs text-destructive text-center">
//                   Staking period has ended
//                 </p>
//               )}
//             </div>
//           </Card>

//           {/* Withdraw Form */}
//           <Card className="p-6 border border-border bg-card">
//             <div className="space-y-4">
//               <div>
//                 <h4 className="text-lg font-semibold text-foreground mb-2">
//                   Withdraw Tokens
//                 </h4>
//                 <p className="text-sm text-muted-foreground">
//                   Withdraw your staked tokens (claims rewards automatically)
//                 </p>
//               </div>

//               <div className="space-y-2">
//                 <label className="block text-sm font-medium text-foreground">
//                   Amount
//                 </label>
//                 <div className="flex gap-2">
//                   <Input
//                     type="number"
//                     placeholder="0.00"
//                     value={withdrawAmount}
//                     onChange={(e) => setWithdrawAmount(e.target.value)}
//                     disabled={withdrawLoading || stakedAmount === 0}
//                     className="flex-1"
//                   />
//                   <Button
//                     type="button"
//                     variant="outline"
//                     onClick={() => setWithdrawAmount(stakedAmount.toString())}
//                     disabled={withdrawLoading || stakedAmount === 0}
//                     className="px-4 bg-transparent"
//                   >
//                     Max
//                   </Button>
//                 </div>
//                 <p className="text-xs text-muted-foreground">
//                   Staked:{" "}
//                   {stakedAmount.toLocaleString(undefined, {
//                     maximumFractionDigits: 2,
//                   })}{" "}
//                   {MOCK_STAKING_DATA.stakeToken}
//                 </p>
//               </div>

//               <Button
//                 onClick={handleWithdraw}
//                 disabled={
//                   withdrawLoading || stakedAmount === 0 || !withdrawAmount
//                 }
//                 className="w-full"
//                 size="lg"
//                 variant="secondary"
//               >
//                 {withdrawLoading ? "Processing..." : "Withdraw"}
//               </Button>

//               {stakedAmount === 0 && (
//                 <p className="text-xs text-destructive text-center">
//                   No tokens to withdraw
//                 </p>
//               )}
//             </div>
//           </Card>
//         </div>

//         {/* Rewards Section */}
//         <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
//           {/* Claim Rewards */}
//           <Card className="p-6 border border-border bg-card">
//             <div className="space-y-4">
//               <div>
//                 <h4 className="text-lg font-semibold text-foreground mb-2">
//                   Claim Rewards
//                 </h4>
//                 <p className="text-sm text-muted-foreground">
//                   Harvest your accumulated rewards
//                 </p>
//               </div>

//               <div className="flex items-end justify-between">
//                 <div>
//                   <p className="text-xs text-muted-foreground mb-1">
//                     Available to Claim
//                   </p>
//                   <p className="text-2xl font-bold text-accent">
//                     {pendingRewards.toLocaleString(undefined, {
//                       maximumFractionDigits: 4,
//                     })}
//                   </p>
//                   <p className="text-xs text-muted-foreground mt-1">
//                     {MOCK_STAKING_DATA.rewardToken} Tokens
//                   </p>
//                 </div>
//                 <Button
//                   onClick={handleClaim}
//                   disabled={claimLoading || pendingRewards <= 0}
//                   size="lg"
//                   className="bg-accent text-accent-foreground hover:opacity-90"
//                 >
//                   {claimLoading ? "Processing..." : "Claim"}
//                 </Button>
//               </div>
//             </div>
//           </Card>

//           {/* Emergency Withdraw */}
//           <Card className="p-6 border border-destructive/20 bg-destructive/5">
//             <div className="space-y-4">
//               <div>
//                 <h4 className="text-lg font-semibold text-foreground mb-2">
//                   Emergency Withdraw
//                 </h4>
//                 <p className="text-sm text-muted-foreground">
//                   Withdraw all tokens without claiming rewards (use with
//                   caution)
//                 </p>
//               </div>

//               <Button
//                 onClick={() => setEmergencyOpen(true)}
//                 disabled={stakedAmount === 0}
//                 variant="destructive"
//                 className="w-full"
//                 size="lg"
//               >
//                 Emergency Withdraw All
//               </Button>

//               {stakedAmount === 0 && (
//                 <p className="text-xs text-muted-foreground text-center">
//                   No tokens to withdraw
//                 </p>
//               )}
//             </div>
//           </Card>
//         </div>
//       </main>

//       {/* Emergency Withdrawal Dialog */}
//       <AlertDialog open={emergencyOpen} onOpenChange={setEmergencyOpen}>
//         <AlertDialogContent>
//           <AlertDialogHeader>
//             <AlertDialogTitle>Emergency Withdraw</AlertDialogTitle>
//             <AlertDialogDescription>
//               You are about to withdraw all{" "}
//               {stakedAmount.toLocaleString(undefined, {
//                 maximumFractionDigits: 2,
//               })}{" "}
//               {MOCK_STAKING_DATA.stakeToken} without claiming your pending
//               rewards. This action cannot be undone.
//             </AlertDialogDescription>
//           </AlertDialogHeader>
//           <AlertDialogFooter>
//             <AlertDialogCancel>Cancel</AlertDialogCancel>
//             <AlertDialogAction
//               onClick={handleEmergencyWithdraw}
//               disabled={emergencyLoading}
//               className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
//             >
//               {emergencyLoading ? "Processing..." : "Confirm Withdraw"}
//             </AlertDialogAction>
//           </AlertDialogFooter>
//         </AlertDialogContent>
//       </AlertDialog>
//     </div>
//   );
// }
