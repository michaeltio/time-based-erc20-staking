// //SPDX-License-Identifier: MIT

// pragma solidity 0.8.28;

// import {BaseTest} from "../../helpers/Base.t.sol";

// contract PendingRewardTest is BaseTest {
//     function setUp() public override {
//         super.setUp();
//     }

//     function testGetPendingRewardsZeroWithNoStake() public view {
//         assertEq(staking.getPendingRewards(user1), 0);
//     }

//     function testGetPendingRewardsAfterStaking() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending = staking.getPendingRewards(user1);
//         assertGt(pending, 0);
//     }

//     function testGetPendingRewardsIncreaseWithTime() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending1 = staking.getPendingRewards(user1);
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending2 = staking.getPendingRewards(user1);
//         assertGt(pending2, pending1);
//     }

//     function testGetPendingRewardsMultipleUsers() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.prank(user2);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user2);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending1 = staking.getPendingRewards(user1);
//         uint256 pending2 = staking.getPendingRewards(user2);
//         assertGt(pending1, 0);
//         assertGt(pending2, 0);
//     }

//     function testGetPendingRewardsProportionalToStake() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.prank(user2);
//         stakeToken.approve(address(staking), 300);
//         vm.prank(user2);
//         staking.stake(300);
//         vm.warp(block.timestamp + 1 days);
//         uint256 pending1 = staking.getPendingRewards(user1);
//         uint256 pending2 = staking.getPendingRewards(user2);
//         assertApproxEqRel(pending2, pending1 * 3, 0.01e18);
//     }

//     function testGetPendingRewardsAfterClaim() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.claimRewards();
//         assertEq(staking.getPendingRewards(user1), 0);
//     }

//     function testGetPendingRewardsAfterRewardPeriodEnds() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.warp(block.timestamp + 31 days);
//         uint256 pending = staking.getPendingRewards(user1);
//         uint256 expectedMax = 30 days * 1e18;
//         assertApproxEqRel(pending, expectedMax, 0.01e18);
//     }

//     function testGetPendingRewardsAccuracy() public {
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 hours);
//         uint256 pending = staking.getPendingRewards(user1);
//         uint256 expected = 1 hours * 1e18;
//         assertApproxEqRel(pending, expected, 0.01e18);
//     }

//     function testGetPendingRewardsAfterWithdraw() public {
//         vm.startPrank(user1);
//         stakeToken.approve(address(staking), 100);
//         staking.stake(100);
//         vm.stopPrank();
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(user1);
//         staking.withdraw(50);
//         assertEq(staking.getPendingRewards(user1), 0);
//     }

//     function testGetPendingRewardsWithZeroRate() public {
//         vm.prank(owner);
//         staking.setRewardRate(0);
//         vm.prank(user1);
//         stakeToken.approve(address(staking), 100);
//         vm.prank(user1);
//         staking.stake(100);
//         vm.warp(block.timestamp + 1 days);
//         assertEq(staking.getPendingRewards(user1), 0);
//     }
// }
