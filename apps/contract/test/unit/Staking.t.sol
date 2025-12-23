//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {Staking} from "../../contracts/Staking.sol";
import {MockERC20} from "../mocks/MockERC20.sol";

contract TestStaking is Test {
    Staking staking;
    MockERC20 stakeToken;
    MockERC20 rewardToken;

    address owner;
    address user1;
    address user2;

    function setUp() public {
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);

        stakeToken = new MockERC20("StakeToken", "SKT");
        rewardToken = new MockERC20("RewardToken", "RWT");
        staking = new Staking(address(stakeToken), address(rewardToken));

        stakeToken.mint(user1, 1000);
        stakeToken.mint(user2, 1000);
        rewardToken.mint(address(staking), 1000000);

        staking.setRewardEndTime(block.timestamp + 30 days);
        staking.setRewardRate(10);
    }

    function testStakeSuccessfull() public {
        vm.startPrank(user1);

        stakeToken.approve(address(staking), 100);
        staking.stake(100);

        vm.stopPrank();

        assertEq(staking.totalStaked(), 100);
        assertEq(staking.getStakedBalance(user1), 100);
    }

    function testStakeZeroAmount() public {
        vm.startPrank(user1);

        stakeToken.approve(address(staking), 0);
        vm.expectRevert("Cannot stake zero tokens");
        staking.stake(0);
        vm.stopPrank();
    }

    function test_RevertIf_StakeAfterRewardEnd() public {
        vm.warp(block.timestamp + 31 days);
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        vm.expectRevert("Staking period ended");
        staking.stake(100);
        vm.stopPrank();
    }

    function test_RevertIf_StakeWithoutApprove() public {
        vm.startPrank(user1);
        vm.expectRevert();
        staking.stake(100);
        vm.stopPrank();
    }

    function test_RevertIf_StakeInSufficientBalance() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 1001);
        vm.expectRevert();
        staking.stake(1001);

        vm.stopPrank();
    }

    function testTotalStakedIncrease() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        vm.stopPrank();
        assertEq(staking.totalStaked(), 100);
    }

    function testRewardDebtUpdatedOnStake() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 200);
        staking.stake(100);

        vm.warp(block.timestamp + 1 hours);
        staking.stake(100);
        vm.stopPrank();

        (, uint256 rewardDebt) = staking.users(user1);

        assertEq(rewardDebt, 72000);
    }

    function testLateStakerDoesNotStealReward() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        vm.stopPrank();

        vm.warp(block.timestamp + 1 hours);

        vm.startPrank(user2);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        vm.stopPrank();

        vm.warp(block.timestamp + 1 hours);

        vm.prank(user1);
        staking.claimRewards();

        vm.prank(user2);
        staking.claimRewards();

        uint256 reward1 = rewardToken.balanceOf(user1);
        uint256 reward2 = rewardToken.balanceOf(user2);

        assertGt(reward1, reward2);
        assertEq(reward2, 0);
    }

    function testStakeTwiceAccumulatesCorrectly() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 200);
        staking.stake(100);
        assertEq(staking.totalStaked(), 100);
        staking.stake(100);
        assertEq(staking.totalStaked(), 200);
        vm.stopPrank();
    }

    //???
    function testMultipleStakersFairDistribution() public {
        vm.warp(100);

        vm.prank(user1);
        staking.stake(100);

        vm.prank(user2);
        staking.stake(300);

        vm.warp(100 + 1 hours);

        vm.prank(user1);
        staking.claimRewards();

        vm.prank(user2);
        staking.claimRewards();

        uint256 reward1 = rewardToken.balanceOf(user1);
        uint256 reward2 = rewardToken.balanceOf(user2);

        assertGt(reward1, 0);
        assertGt(reward2, 0);

        // user2 stake 3x user1
        assertApproxEqRel(
            reward2,
            reward1 * 3,
            0.01e18 // 1% toleransi (Foundry pakai fixed 1e18)
        );
    }

    //???
    function testStakeWithdrawDoesNotBreakOthers() public {
        vm.warp(100);

        // user1 & user2 stake
        vm.prank(user1);
        staking.stake(100);

        vm.prank(user2);
        staking.stake(300);

        vm.warp(100 + 1 hours);

        // user1 withdraw
        vm.prank(user1);
        staking.withdraw(100);

        // lanjut waktu
        vm.warp(100 + 2 hours);

        // user2 claim reward
        vm.prank(user2);
        staking.claimRewards();

        uint256 reward2 = rewardToken.balanceOf(user2);

        // reward user2 tetap masuk akal
        assertGt(reward2, 0);
    }

    //???
    function testStakeNonReentrant() public {}

    //???
    function testStakeSameBlockNoReward() public {}

    //withdraw
    function testWithdrawSuccessfull() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        assertEq(stakeToken.balanceOf(address(user1)), 900);
        assertEq(staking.totalStaked(), 100);
        staking.withdraw(100);
        assertEq(stakeToken.balanceOf(address(user1)), 1000);
        assertEq(staking.totalStaked(), 0);
    }

    function test_RevertIf_WithdrawZeroAmount() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        assertEq(stakeToken.balanceOf(address(user1)), 900);
        assertEq(staking.totalStaked(), 100);
        vm.expectRevert("Cannot Withdraw 0 Amount");
        staking.withdraw(0);
        vm.stopPrank();
    }

    function testTotalStakedDecrease() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        staking.withdraw(50);
        assertEq(staking.totalStaked(), 50);
        staking.withdraw(50);
        assertEq(staking.totalStaked(), 0);
        vm.stopPrank();
    }

    function testDoubleWithdrawDecrease() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        assertEq(stakeToken.balanceOf(address(user1)), 900);
        assertEq(staking.totalStaked(), 100);
        staking.withdraw(50);
        assertEq(stakeToken.balanceOf(address(user1)), 950);
        assertEq(staking.totalStaked(), 50);
        staking.withdraw(50);
        assertEq(stakeToken.balanceOf(address(user1)), 1000);
        assertEq(staking.totalStaked(), 0);
        vm.stopPrank();
    }

    function test_RevertIf_WithdrawMoreThanStake() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        assertEq(stakeToken.balanceOf(address(user1)), 900);
        assertEq(staking.totalStaked(), 100);
        vm.expectRevert("Not enough staked");
        staking.withdraw(150);
        vm.stopPrank();
    }

    function testWithdrawWithNoStake() public {}

    function testWithdrawAllStake() public {}

    function testWithdrawPartialStake() public {}

    function testWithdrawMultipleTimes() public {}

    function testWithdrawUpdatesRewardDebt() public {}

    function testWithdrawClaimsRewardsFirst() public {}

    function testWithdrawTransfersTokensBack() public {}

    function testWithdrawEmitsEvent() public {}

    function testWithdrawAfterRewardPeriodEnds() public {}

    function testWithdrawDoesNotAffectOtherUsers() public {}

    function testWithdrawThenStakeAgain() public {}

    function testWithdrawWithPendingRewards() public {}

    function testWithdrawReentrancyProtection() public {}

    function testWithdrawWithMaliciousToken() public {}

    function testWithdrawRevertsOnTransferFail() public {}

    function testWithdrawUpdatesUserBalance() public {}

    function testWithdrawSameBlockAsStake() public {}

    function testWithdrawByMultipleUsers() public {}

    function testWithdrawMaxUint256() public {}

    function testWithdrawDustAmount() public {}

    // pending rewards

    function testClaimRewardsSuccessful() public {}

    function testClaimRewardsZeroPending() public {}

    function testClaimRewardsWithNoStake() public {}

    function testClaimRewardsMultipleTimes() public {}

    function testClaimRewardsAfterStaking() public {}

    function testClaimRewardsAfterTimeElapsed() public {}

    function testClaimRewardsUpdatesRewardDebt() public {}

    function testClaimRewardsTransfersCorrectAmount() public {}

    function testClaimRewardsEmitsEvent() public {}

    function testClaimRewardsAfterRewardPeriodEnds() public {}

    function testClaimRewardsDoesNotAffectOtherUsers() public {}

    function testClaimRewardsThenStakeAgain() public {}

    function testClaimRewardsThenWithdraw() public {}

    function testClaimRewardsReentrancyProtection() public {}

    function testClaimRewardsWithMaliciousToken() public {}

    function testClaimRewardsRevertsOnTransferFail() public {}

    function testClaimRewardsSameBlockAsStake() public {}

    function testClaimRewardsByMultipleUsers() public {}

    function testClaimRewardsPartialAvailable() public {}

    function testClaimRewardsMaxBalance() public {}

    function testClaimRewardsDustAmount() public {}

    function testClaimRewardsAccumulatesCorrectly() public {}

    function testClaimRewardsAfterPoolUpdate() public {}

    function testClaimRewardsWithZeroRewardRate() public {}

    function testClaimRewardsBeforeStaking() public {}

    // emergency withdraw
    function testEmergencyWithdrawSuccessful() public {}

    function testEmergencyWithdrawWithNoStake() public {}

    function testEmergencyWithdrawLosesPendingRewards() public {}

    function testEmergencyWithdrawResetsUserData() public {}

    function testEmergencyWithdrawDecreasesTotalStaked() public {}

    function testEmergencyWithdrawTransfersTokensBack() public {}

    function testEmergencyWithdrawEmitsEvent() public {}

    function testEmergencyWithdrawDoesNotCallUpdatePool() public {}

    function testEmergencyWithdrawReentrancyProtection() public {}

    function testEmergencyWithdrawByMultipleUsers() public {}

    function testEmergencyWithdrawThenStakeAgain() public {}

    function testEmergencyWithdrawAfterRewardPeriodEnds() public {}

    function testEmergencyWithdrawWithMaliciousToken() public {}

    function testEmergencyWithdrawRevertsOnTransferFail() public {}
}
