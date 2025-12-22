//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {Staking} from "../contracts/Staking.sol";
import {MockERC20} from "./mocks/MockERC20.sol";

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

    function testMultipleStakersFairDistribution() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        vm.stopPrank();

        vm.startPrank(user2);
        stakeToken.approve(address(staking), 300);
        staking.stake(300);
        vm.stopPrank();

        vm.warp(block.timestamp + 1 hours);

        vm.prank(user1);
        staking.claimRewards();

        vm.prank(user2);
        staking.claimRewards();

        uint256 reward1 = rewardToken.balanceOf(user1);
        uint256 reward2 = rewardToken.balanceOf(user2);

        assertGt(reward1, 0);
        assertGt(reward2, 0);

        assertApproxEqAbs(reward2, reward1 * 3, 18000);
    }

    function testStakeWithdrawDoesNotBreakOthers() public {}

    function testStakeNonReentrant() public {}

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

    function test_RevertIf_WithdrawZeroAmount() public {}

    function testTotalStakedDecrease() public {}

    function testDoubleWithdrawDecrease() public {}

    function test_RevertIf_WithdrawMoreThanStake() public {}
}
