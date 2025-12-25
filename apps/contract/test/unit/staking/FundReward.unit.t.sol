// //SPDX-License-Identifier: MIT

// pragma solidity 0.8.28;

// import {BaseTest} from "../../helpers/Base.t.sol";

// contract FundRewardTest is BaseTest {
//     function setUp() public override {
//         super.setUp();
//     }

//     function testFundRewardsSuccess() public {
//         uint256 fundAmount = 10000e18;
//         vm.startPrank(owner);
//         rewardToken.mint(owner, fundAmount);
//         rewardToken.approve(address(staking), fundAmount);
//         uint256 balanceBefore = rewardToken.balanceOf(address(staking));
//         staking.fundRewards(fundAmount);
//         uint256 balanceAfter = rewardToken.balanceOf(address(staking));
//         assertEq(balanceAfter - balanceBefore, fundAmount);
//         vm.stopPrank();
//     }

//     function testFundRewardsEmitsEvent() public {
//         uint256 fundAmount = 10000e18;
//         vm.startPrank(owner);
//         rewardToken.mint(owner, fundAmount);
//         rewardToken.approve(address(staking), fundAmount);
//         vm.expectEmit(true, true, true, true);
//         emit RewardsFunded(fundAmount);
//         staking.fundRewards(fundAmount);
//         vm.stopPrank();
//     }

//     function testFundRewardsOnlyOwner() public {
//         vm.startPrank(user1);
//         vm.expectRevert();
//         staking.fundRewards(10000e18);
//         vm.stopPrank();
//     }

//     function testFundRewardsZeroAmount() public {
//         vm.startPrank(owner);
//         vm.expectRevert("Zero amount");
//         staking.fundRewards(0);
//         vm.stopPrank();
//     }

//     function testFundRewardsWithoutApproval() public {
//         uint256 fundAmount = 10000e18;
//         vm.startPrank(owner);
//         rewardToken.mint(owner, fundAmount);
//         vm.expectRevert();
//         staking.fundRewards(fundAmount);
//         vm.stopPrank();
//     }

//     function testFundRewardsMultipleTimes() public {
//         vm.startPrank(owner);
//         rewardToken.mint(owner, 30000e18);
//         rewardToken.approve(address(staking), 30000e18);
//         uint256 balanceBefore = rewardToken.balanceOf(address(staking));
//         staking.fundRewards(10000e18);
//         staking.fundRewards(10000e18);
//         staking.fundRewards(10000e18);
//         uint256 balanceAfter = rewardToken.balanceOf(address(staking));
//         assertEq(balanceAfter - balanceBefore, 30000e18);
//         vm.stopPrank();
//     }

//     function testFundRewardsLargeAmount() public {
//         uint256 largeAmount = 1000000000e18;
//         vm.startPrank(owner);
//         rewardToken.mint(owner, largeAmount);
//         rewardToken.approve(address(staking), largeAmount);
//         staking.fundRewards(largeAmount);
//         assertEq(
//             rewardToken.balanceOf(address(staking)),
//             REWARD_POOL + largeAmount
//         );
//         vm.stopPrank();
//     }

//     function testFundRewardsIncreasesBalance() public {
//         uint256 fundAmount = 50000e18;
//         vm.startPrank(owner);
//         rewardToken.mint(owner, fundAmount);
//         rewardToken.approve(address(staking), fundAmount);
//         uint256 balanceBefore = rewardToken.balanceOf(address(staking));
//         staking.fundRewards(fundAmount);
//         uint256 balanceAfter = rewardToken.balanceOf(address(staking));
//         assertGt(balanceAfter, balanceBefore);
//         vm.stopPrank();
//     }
// }
