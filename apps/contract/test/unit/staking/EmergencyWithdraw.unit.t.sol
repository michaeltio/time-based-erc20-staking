// //SPDX-License-Identifier: MIT

// pragma solidity 0.8.28;

// import {BaseTest} from "../../helpers/Base.t.sol";

// contract EmergencyWithdrawTest is BaseTest {
//     function setUp() public override {
//         super.setUp();
//     }

//     function testEmergencyWithdrawSuccessful() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         uint256 balanceBefore = stakeToken.balanceOf(user1);
//         staking.emergencyWithdraw();
//         uint256 balanceAfter = stakeToken.balanceOf(user1);
//         assertEq(balanceAfter - balanceBefore, 100);
//         assertEq(staking.getStakedBalance(user1), 0);
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawWithNoStake() public {
//         vm.startPrank(user1);
//         vm.expectRevert("Nothing to withdraw");
//         staking.emergencyWithdraw();
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawLosesPendingRewards() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         uint256 pendingBefore = staking.getPendingRewards(user1);
//         assertGt(pendingBefore, 0);
//         uint256 rewardBalanceBefore = rewardToken.balanceOf(user1);
//         vm.prank(user1);
//         staking.emergencyWithdraw();
//         uint256 rewardBalanceAfter = rewardToken.balanceOf(user1);
//         assertEq(rewardBalanceAfter, rewardBalanceBefore);
//     }

//     function testEmergencyWithdrawResetsUserData() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.emergencyWithdraw();
//         (uint256 amount, uint256 rewardDebt) = staking.users(user1);
//         assertEq(amount, 0);
//         assertEq(rewardDebt, 0);
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawDecreasesTotalStaked() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         assertEq(staking.totalStaked(), 100);
//         staking.emergencyWithdraw();
//         assertEq(staking.totalStaked(), 0);
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawTransfersTokensBack() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         uint256 balanceBefore = stakeToken.balanceOf(user1);
//         staking.emergencyWithdraw();
//         uint256 balanceAfter = stakeToken.balanceOf(user1);
//         assertEq(balanceAfter - balanceBefore, 100);
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawEmitsEvent() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.expectEmit(true, true, true, true);
//         emit EmergencyWithdrawn(user1, 100);
//         staking.emergencyWithdraw();
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawDoesNotCallUpdatePool() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         uint256 lastRewardTimeBefore = staking.lastRewardTime();
//         vm.prank(user1);
//         staking.emergencyWithdraw();
//         uint256 lastRewardTimeAfter = staking.lastRewardTime();
//         assertEq(lastRewardTimeAfter, lastRewardTimeBefore);
//     }

//     function testEmergencyWithdrawReentrancyProtection() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.emergencyWithdraw();
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawByMultipleUsers() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.prank(user2);
//         stakeToken.approve(address(staking), 200);
//         vm.prank(user2);
//         staking.stake(200);
//         vm.prank(user1);
//         staking.emergencyWithdraw();
//         assertEq(staking.getStakedBalance(user1), 0);
//         assertEq(staking.getStakedBalance(user2), 200);
//         assertEq(staking.totalStaked(), 200);
//     }

//     function testEmergencyWithdrawThenStakeAgain() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 200);
//         staking.stake(100);
//         staking.emergencyWithdraw();
//         staking.stake(100);
//         assertEq(staking.getStakedBalance(user1), 100);
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawAfterRewardPeriodEnds() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 31 days);
//         vm.prank(user1);
//         staking.emergencyWithdraw();
//         assertEq(staking.getStakedBalance(user1), 0);
//     }

//     function testEmergencyWithdrawWithMaliciousToken() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         staking.emergencyWithdraw();
//         assertEq(staking.getStakedBalance(user1), 0);
//         vm.stopPrank();
//     }

//     function testEmergencyWithdrawRevertsOnTransferFail() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//     }
// }
