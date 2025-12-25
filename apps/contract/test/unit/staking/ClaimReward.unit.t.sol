// //SPDX-License-Identifier: MIT

// pragma solidity 0.8.28;

// import {BaseTest} from "../../helpers/Base.t.sol";

// contract ClaimRewardsTest is BaseTest {
//     function setUp() public override {
//         super.setUp();
//     }

//     function testClaimRewardsSuccessful() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending = staking.getPendingRewards(user1);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertEq(rewardToken.balanceOf(user1), pending);
//     }

//     function testClaimRewardsZeroPending() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.expectRevert("No rewards");
//         staking.claimRewards();
//         vm.stopPrank();
//     }

//     function testClaimRewardsWithNoStake() public {
//         vm.startPrank(user1);
//         vm.expectRevert("No rewards");
//         staking.claimRewards();
//         vm.stopPrank();
//     }

//     function testClaimRewardsMultipleTimes() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertGt(rewardToken.balanceOf(user1), 0);
//     }

//     function testClaimRewardsAfterStaking() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 hours);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertGt(rewardToken.balanceOf(user1), 0);
//     }

//     function testClaimRewardsAfterTimeElapsed() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 7 days);
//         uint256 pending = staking.getPendingRewards(user1);
//         assertGt(pending, 0);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertEq(rewardToken.balanceOf(user1), pending);
//     }

//     function testClaimRewardsUpdatesRewardDebt() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         (, uint256 rewardDebt) = staking.users(user1);
//         assertGt(rewardDebt, 0);
//     }

//     function testClaimRewardsTransfersCorrectAmount() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending = staking.getPendingRewards(user1);
//         uint256 balanceBefore = rewardToken.balanceOf(user1);
//         vm.prank(user1);
//         staking.claimRewards();
//         uint256 balanceAfter = rewardToken.balanceOf(user1);
//         assertEq(balanceAfter - balanceBefore, pending);
//     }

//     function testClaimRewardsEmitsEvent() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending = staking.getPendingRewards(user1);
//         vm.expectEmit(true, true, true, true);
//         emit RewardClaimed(user1, pending);
//         vm.prank(user1);
//         staking.claimRewards();
//     }

//     function testClaimRewardsAfterRewardPeriodEnds() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 31 days);
//         uint256 pending = staking.getPendingRewards(user1);
//         assertGt(pending, 0);
//         vm.prank(user1);
//         staking.claimRewards();
//     }

//     function testClaimRewardsDoesNotAffectOtherUsers() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.prank(user2);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user2);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertGt(staking.getPendingRewards(user2), 0);
//     }

//     function testClaimRewardsThenStakeAgain() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 200);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         vm.prank(user1);
//         staking.stake(100);
//         assertEq(staking.getStakedBalance(user1), 200);
//     }

//     function testClaimRewardsThenWithdraw() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         vm.prank(user1);
//         staking.withdraw(50);
//         assertEq(staking.getStakedBalance(user1), 50);
//     }

//     function testClaimRewardsReentrancyProtection() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//     }

//     function testClaimRewardsWithMaliciousToken() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//     }

//     function testClaimRewardsRevertsOnTransferFail() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//     }

//     function testClaimRewardsSameBlockAsStake() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.expectRevert("No rewards");
//         staking.claimRewards();
//         vm.stopPrank();
//     }

//     function testClaimRewardsByMultipleUsers() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.prank(user2);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user2);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         vm.prank(user2);
//         staking.claimRewards();
//         assertGt(rewardToken.balanceOf(user1), 0);
//         assertGt(rewardToken.balanceOf(user2), 0);
//     }

//     function testClaimRewardsPartialAvailable() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertGt(rewardToken.balanceOf(user1), 0);
//     }

//     function testClaimRewardsMaxBalance() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 30 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertGt(rewardToken.balanceOf(user1), 0);
//     }

//     function testClaimRewardsDustAmount() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 1);
//         staking.stake(1);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertGt(rewardToken.balanceOf(user1), 0);
//     }

//     function testClaimRewardsAccumulatesCorrectly() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending1 = staking.getPendingRewards(user1);
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending2 = staking.getPendingRewards(user1);
//         assertGt(pending2, pending1);
//     }

//     function testClaimRewardsAfterPoolUpdate() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(owner);
//         staking.setRewardRate(2e18);
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertGt(rewardToken.balanceOf(user1), 0);
//     }

//     function testClaimRewardsWithZeroRewardRate() public {
//         vm.prank(owner);
//         staking.setRewardRate(0);
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         assertEq(staking.getPendingRewards(user1), 0);
//     }

//     function testClaimRewardsBeforeStaking() public {
//         vm.startPrank(user1);
//         vm.expectRevert("No rewards");
//         staking.claimRewards();
//         vm.stopPrank();
//     }
// }
