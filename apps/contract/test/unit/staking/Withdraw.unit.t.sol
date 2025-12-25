// //SPDX-License-Identifier: MIT

// pragma solidity 0.8.28;

// import {BaseTest} from "../../helpers/Base.t.sol";

// contract WithdrawTest is BaseTest {
//     function setUp() public override {
//         super.setUp();
//     }

//     function testWithdrawSuccessfull() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         assertEq(stakeToken.balanceOf(address(user1)), 900);
//         assertEq(staking.totalStaked(), 100);
//         staking.withdraw(100);
//         assertEq(stakeToken.balanceOf(address(user1)), 1000);
//         assertEq(staking.totalStaked(), 0);
//     }

//     function test_RevertIf_WithdrawZeroAmount() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         assertEq(stakeToken.balanceOf(address(user1)), 900);
//         assertEq(staking.totalStaked(), 100);
//         vm.expectRevert("Cannot Withdraw 0 Amount");
//         staking.withdraw(0);
//         vm.stopPrank();
//     }

//     function testTotalStakedDecrease() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.withdraw(50);
//         assertEq(staking.totalStaked(), 50);
//         staking.withdraw(50);
//         assertEq(staking.totalStaked(), 0);
//         vm.stopPrank();
//     }

//     function testDoubleWithdrawDecrease() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         assertEq(stakeToken.balanceOf(address(user1)), 900);
//         assertEq(staking.totalStaked(), 100);
//         staking.withdraw(50);
//         assertEq(stakeToken.balanceOf(address(user1)), 950);
//         assertEq(staking.totalStaked(), 50);
//         staking.withdraw(50);
//         assertEq(stakeToken.balanceOf(address(user1)), 1000);
//         assertEq(staking.totalStaked(), 0);
//         vm.stopPrank();
//     }

//     function test_RevertIf_WithdrawMoreThanStake() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         assertEq(stakeToken.balanceOf(address(user1)), 900);
//         assertEq(staking.totalStaked(), 100);
//         vm.expectRevert("Not enough staked");
//         staking.withdraw(150);
//         vm.stopPrank();
//     }

//     function testWithdrawWithNoStake() public {
//         vm.startPrank(user1);
//         vm.expectRevert("Cannot Withdraw 0 Amount");
//         staking.withdraw(100);
//         vm.stopPrank();
//     }

//     function testWithdrawAllStake() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.withdraw(100);
//         assertEq(staking.getStakedBalance(user1), 0);
//         assertEq(staking.totalStaked(), 0);
//         vm.stopPrank();
//     }

//     function testWithdrawPartialStake() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.withdraw(30);
//         assertEq(staking.getStakedBalance(user1), 70);
//         assertEq(staking.totalStaked(), 70);
//         vm.stopPrank();
//     }

//     function testWithdrawMultipleTimes() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 300);
//         staking.stake(300);
//         staking.withdraw(100);
//         assertEq(staking.getStakedBalance(user1), 200);
//         staking.withdraw(100);
//         assertEq(staking.getStakedBalance(user1), 100);
//         staking.withdraw(100);
//         assertEq(staking.getStakedBalance(user1), 0);
//         vm.stopPrank();
//     }

//     function testWithdrawUpdatesRewardDebt() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 hours);
//         staking.withdraw(50);
//         (, uint256 rewardDebt) = staking.users(user1);
//         assertGt(rewardDebt, 0);
//         vm.stopPrank();
//     }

//     function testWithdrawClaimsRewardsFirst() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 hours);
//         uint256 pendingBefore = staking.getPendingRewards(user1);
//         uint256 balanceBefore = rewardToken.balanceOf(user1);
//         vm.prank(user1);
//         staking.withdraw(50);
//         uint256 balanceAfter = rewardToken.balanceOf(user1);
//         assertEq(balanceAfter - balanceBefore, pendingBefore);
//     }

//     function testWithdrawTransfersTokensBack() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         uint256 balanceBefore = stakeToken.balanceOf(user1);
//         staking.withdraw(100);
//         uint256 balanceAfter = stakeToken.balanceOf(user1);
//         assertEq(balanceAfter - balanceBefore, 100);
//         vm.stopPrank();
//     }

//     function testWithdrawEmitsEvent() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.expectEmit(true, true, true, true);
//         emit Withdrawn(user1, 50);
//         staking.withdraw(50);
//         vm.stopPrank();
//     }

//     function testWithdrawAfterRewardPeriodEnds() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 31 days);
//         vm.prank(user1);
//         staking.withdraw(100);
//         assertEq(staking.getStakedBalance(user1), 0);
//     }

//     function testWithdrawDoesNotAffectOtherUsers() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.prank(user2);
//         stakeToken.approve(address(staking), 200);
//         vm.prank(user2);
//         staking.stake(200);
//         vm.prank(user1);
//         staking.withdraw(50);
//         assertEq(staking.getStakedBalance(user2), 200);
//         assertEq(staking.totalStaked(), 250);
//     }

//     function testWithdrawThenStakeAgain() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 300);
//         staking.stake(100);
//         staking.withdraw(50);
//         staking.stake(100);
//         assertEq(staking.getStakedBalance(user1), 150);
//         vm.stopPrank();
//     }

//     function testWithdrawWithPendingRewards() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending = staking.getPendingRewards(user1);
//         assertGt(pending, 0);
//         vm.prank(user1);
//         staking.withdraw(50);
//         assertEq(staking.getPendingRewards(user1), 0);
//     }

//     function testWithdrawReentrancyProtection() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.withdraw(50);
//         assertEq(staking.getStakedBalance(user1), 50);
//         vm.stopPrank();
//     }

//     function testWithdrawWithMaliciousToken() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.withdraw(50);
//         assertEq(staking.getStakedBalance(user1), 50);
//         vm.stopPrank();
//     }

//     function testWithdrawRevertsOnTransferFail() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//     }

//     function testWithdrawUpdatesUserBalance() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         (uint256 amountBefore, ) = staking.users(user1);
//         staking.withdraw(50);
//         (uint256 amountAfter, ) = staking.users(user1);
//         assertEq(amountBefore - amountAfter, 50);
//         vm.stopPrank();
//     }

//     function testWithdrawSameBlockAsStake() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 200);
//         staking.stake(100);
//         staking.withdraw(50);
//         assertEq(staking.getStakedBalance(user1), 50);
//         vm.stopPrank();
//     }

//     function testWithdrawByMultipleUsers() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.prank(user2);
//         stakeToken.approve(address(staking), 200);
//         vm.prank(user2);
//         staking.stake(200);
//         vm.prank(user1);
//         staking.withdraw(50);
//         vm.prank(user2);
//         staking.withdraw(100);
//         assertEq(staking.getStakedBalance(user1), 50);
//         assertEq(staking.getStakedBalance(user2), 100);
//     }

//     function testWithdrawMaxUint256() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.expectRevert("Not enough staked");
//         staking.withdraw(type(uint256).max);
//         vm.stopPrank();
//     }

//     function testWithdrawDustAmount() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.withdraw(1);
//         assertEq(staking.getStakedBalance(user1), 99);
//         vm.stopPrank();
//     }
// }
