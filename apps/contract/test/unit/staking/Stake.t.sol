//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {BaseTest} from "../../Base.t.sol";

contract StakeTest is BaseTest {
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
}
