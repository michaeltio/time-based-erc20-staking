//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {Staking} from "../contracts/Staking.sol";
import {MockERC20} from "./mocks/MockERC20.sol";

contract BaseTest is Test {
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
        rewardToken.mint(address(staking), 500);

        staking.setRewardEndTime(block.timestamp + 30 days);
        staking.setRewardRate(10);
    }
}
