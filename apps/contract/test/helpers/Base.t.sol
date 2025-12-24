//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console2} from "forge-std/Test.sol";
import {Staking} from "../../contracts/Staking.sol";
import {MockERC20} from "./MockERC20.sol";

abstract contract BaseTest is Test {
    Staking public staking;
    MockERC20 public stakeToken;
    MockERC20 public rewardToken;

    address public owner;
    address public user;
    address public user1;
    address public user2;
    address public user3;
    address public attacker;

    uint256 public constant INITIAL_BALANCE = 10_000e18;
    uint256 public constant REWARD_POOL = 1_000_000e18;
    uint256 public constant REWARD_RATE = 1e18;
    uint256 public constant REWARD_DURATION = 30 days;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 amount);
    event EmergencyWithdrawn(address indexed user, uint256 amount);
    event RewardRateUpdated(uint256 newRate);
    event RewardsFunded(uint256 amount);

    function setUp() public virtual {
        owner = makeAddr("owner");
        user = makeAddr("user");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
        user3 = makeAddr("user3");
        attacker = makeAddr("attacker");

        vm.startPrank(owner);

        stakeToken = new MockERC20("StakeToken", "STK");
        rewardToken = new MockERC20("RewardToken", "RWT");
        staking = new Staking(address(stakeToken), address(rewardToken));

        stakeToken.mint(owner, REWARD_POOL);
        stakeToken.mint(user, INITIAL_BALANCE);
        stakeToken.mint(user1, INITIAL_BALANCE);
        stakeToken.mint(user2, INITIAL_BALANCE);
        stakeToken.mint(user3, INITIAL_BALANCE);
        stakeToken.mint(attacker, INITIAL_BALANCE);

        rewardToken.mint(owner, REWARD_POOL);
        rewardToken.approve(address(staking), REWARD_POOL);
        staking.fundRewards(REWARD_POOL);

        staking.setRewardRate(REWARD_RATE);
        staking.setRewardEndTime(block.timestamp + REWARD_DURATION);

        vm.stopPrank();
    }

    function _setupStake(address _user, uint256 _amount) internal {
        vm.startPrank(_user);
        stakeToken.approve(address(staking), _amount);
        staking.stake(_amount);
        vm.stopPrank();
    }

    function _advanceTime(uint256 _seconds) internal {
        vm.warp(block.timestamp + _seconds);
    }

    function _advanceBlocks(uint256 _blocks) internal {
        vm.roll(block.number + _blocks);
    }

    function _advanceTimeAndBlocks(uint256 _seconds, uint256 _blocks) internal {
        vm.warp(block.timestamp + _seconds);
        vm.roll(block.number + _blocks);
    }

    function _getUserStake(address _user) internal view returns (uint256) {
        return staking.getStakedBalance(_user);
    }

    function _getPendingRewards(address _user) internal view returns (uint256) {
        return staking.getPendingRewards(_user);
    }

    function _getTotalStaked() internal view returns (uint256) {
        return staking.totalStaked();
    }

    function _getRewardRate() internal view returns (uint256) {
        return staking.rewardRate();
    }

    function _getRewardEndTime() internal view returns (uint256) {
        return staking.rewardEndTime();
    }

    function _getLastRewardTime() internal view returns (uint256) {
        return staking.lastRewardTime();
    }

    function _getAccRewardPerShare() internal view returns (uint256) {
        return staking.accRewardPerShare();
    }

    function _getUserInfo(
        address _user
    ) internal view returns (uint256 amount, uint256 rewardDebt) {
        return staking.users(_user);
    }

    function _expectEmitStaked(address _user, uint256 _amount) internal {
        vm.expectEmit(true, true, true, true);
        emit Staked(_user, _amount);
    }

    function _expectEmitWithdrawn(address _user, uint256 _amount) internal {
        vm.expectEmit(true, true, true, true);
        emit Withdrawn(_user, _amount);
    }

    function _expectEmitRewardClaimed(address _user, uint256 _amount) internal {
        vm.expectEmit(true, true, true, true);
        emit RewardClaimed(_user, _amount);
    }

    function _expectEmitEmergencyWithdrawn(
        address _user,
        uint256 _amount
    ) internal {
        vm.expectEmit(true, true, true, true);
        emit EmergencyWithdrawn(_user, _amount);
    }

    function _expectEmitRewardRateUpdated(uint256 _newRate) internal {
        vm.expectEmit(true, true, true, true);
        emit RewardRateUpdated(_newRate);
    }

    function _expectEmitRewardsFunded(uint256 _amount) internal {
        vm.expectEmit(true, true, true, true);
        emit RewardsFunded(_amount);
    }
}
