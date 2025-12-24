//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {BaseTest} from "../../helpers/Base.t.sol";

contract StakedBalanceTest is BaseTest {
    function testGetStakedBalanceZeroInitially() public view {
        assertEq(staking.getStakedBalance(user1), 0);
    }

    function testGetStakedBalanceAfterStake() public {
        vm.prank(user1);
        stakeToken.approve(address(staking), 100);
        vm.prank(user1);
        staking.stake(100);
        assertEq(staking.getStakedBalance(user1), 100);
    }

    function testGetStakedBalanceAfterMultipleStakes() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 300);
        staking.stake(100);
        assertEq(staking.getStakedBalance(user1), 100);
        staking.stake(100);
        assertEq(staking.getStakedBalance(user1), 200);
        staking.stake(100);
        assertEq(staking.getStakedBalance(user1), 300);
        vm.stopPrank();
    }

    function testGetStakedBalanceAfterWithdraw() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        staking.withdraw(50);
        assertEq(staking.getStakedBalance(user1), 50);
        vm.stopPrank();
    }

    function testGetStakedBalanceAfterFullWithdraw() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        staking.withdraw(100);
        assertEq(staking.getStakedBalance(user1), 0);
        vm.stopPrank();
    }

    function testGetStakedBalanceAfterEmergencyWithdraw() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        staking.emergencyWithdraw();
        assertEq(staking.getStakedBalance(user1), 0);
        vm.stopPrank();
    }

    function testGetStakedBalanceMultipleUsers() public {
        vm.prank(user1);
        stakeToken.approve(address(staking), 100);
        vm.prank(user1);
        staking.stake(100);
        vm.prank(user2);
        stakeToken.approve(address(staking), 200);
        vm.prank(user2);
        staking.stake(200);
        assertEq(staking.getStakedBalance(user1), 100);
        assertEq(staking.getStakedBalance(user2), 200);
    }

    function testGetStakedBalanceDoesNotChangeWithTime() public {
        vm.prank(user1);
        stakeToken.approve(address(staking), 100);
        vm.prank(user1);
        staking.stake(100);
        assertEq(staking.getStakedBalance(user1), 100);
        vm.warp(block.timestamp + 10 days);
        assertEq(staking.getStakedBalance(user1), 100);
    }

    function testGetStakedBalanceAfterClaimRewards() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 100);
        staking.stake(100);
        vm.stopPrank();
        vm.warp(block.timestamp + 1 days);
        vm.prank(user1);
        staking.claimRewards();
        assertEq(staking.getStakedBalance(user1), 100);
    }

    function testGetStakedBalanceAccuracy() public {
        vm.startPrank(user1);
        stakeToken.approve(address(staking), 12345);
        staking.stake(12345);
        assertEq(staking.getStakedBalance(user1), 12345);
        vm.stopPrank();
    }
}
