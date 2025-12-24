//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {BaseTest} from "../Base.t.sol";

contract StakingFuzzTest is BaseTest {
    function testFuzz_Stake(uint256 amount) public {
        amount = bound(amount, 1, 1e24);

        vm.startPrank(user);
        stakeToken.approve(address(staking), amount);
        staking.stake(amount);
        vm.stopPrank();

        (uint256 userAmount, ) = staking.users(user);
        assertEq(userAmount, amount);
        assertEq(staking.totalStaked(), amount);
    }

    function testFuzz_Withdraw(
        uint256 stakeAmount,
        uint256 withdrawAmount
    ) public {
        stakeAmount = bound(stakeAmount, 1, 1e24);
        withdrawAmount = bound(withdrawAmount, 1, stakeAmount);

        vm.startPrank(user);
        stakeToken.approve(address(staking), stakeAmount);
        staking.stake(stakeAmount);

        staking.withdraw(withdrawAmount);
        vm.stopPrank();

        (uint256 remaining, ) = staking.users(user);
        assertEq(remaining, stakeAmount - withdrawAmount);
    }

    function testFuzz_ClaimRewards(uint256 amount, uint256 timeSkip) public {
        amount = bound(amount, 1, 1e24);
        timeSkip = bound(timeSkip, 1, 30 days);

        vm.startPrank(user);
        stakeToken.approve(address(staking), amount);
        staking.stake(amount);
        vm.stopPrank();

        vm.warp(block.timestamp + timeSkip);

        vm.prank(user);
        staking.claimRewards();

        (, uint256 rewardDebt) = staking.users(user);
        assertGt(rewardDebt, 0);
    }

    function testFuzz_EmergencyWithdraw(uint256 amount) public {
        amount = bound(amount, 1, 1e24);

        vm.startPrank(user);
        stakeToken.approve(address(staking), amount);
        staking.stake(amount);
        staking.emergencyWithdraw();
        vm.stopPrank();

        (uint256 userAmount, uint256 rewardDebt) = staking.users(user);
        assertEq(userAmount, 0);
        assertEq(rewardDebt, 0);
    }
}
