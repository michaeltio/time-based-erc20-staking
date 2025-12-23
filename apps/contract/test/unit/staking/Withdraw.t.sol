//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {BaseTest} from "../../Base.t.sol";

contract WithdrawTest is BaseTest {
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
}
