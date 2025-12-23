//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {BaseTest} from "../Base.t.sol";

contract StakingFuzzTest is BaseTest {
    function testFuzz_StakeAnyValidAmount(uint256 amount) public {
        amount = bound(amount, 1, 1000);

        vm.startPrank(user1);
        stakeToken.approve(address(staking), amount);
        staking.stake(amount);
        vm.stopPrank();

        assertEq(staking.getStakedBalance(user1), amount);
    }

    function testFuzz_StakeFullRange(uint256 amount) public {
        uint256 userBalance = stakeToken.balanceOf(user1);
        amount = bound(amount, 1, userBalance);

        vm.startPrank(user1);
        stakeToken.approve(address(staking), amount);
        staking.stake(amount);
        vm.stopPrank();

        assertEq(staking.getStakedBalance(user1), amount);
    }

    function testFuzz_RewardCalculationWithDifferentAmounts(
        uint256 amount
    ) public {
        amount = bound(amount, 1, 100);

        vm.startPrank(user1);
        stakeToken.approve(address(staking), amount);
        staking.stake(amount);
        vm.stopPrank();

        vm.warp(block.timestamp + 1 days);

        uint256 reward = staking.getPendingRewards(user1);

        assertGt(reward, 0);
    }
}
