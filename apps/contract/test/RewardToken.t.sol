//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import "forge-std/Test.sol";
import "./RewardToken.sol";

contract RewardTokenTest is Test {
    RewardToken rewardToken;
    address owner;
    address user;

    function setUp() public {
        owner = address(this);
        user = address(0x123);

        rewardToken = new RewardToken();
    }

    function test_NameAndSymbol() public {
        assertEq(rewardToken.name(), "RewardToken");
        assertEq(rewardToken.symbol(), "RWT");
    }

    function test_MintAmountToOwner() public {
        uint256 decimals = rewardToken.decimals();
        uint256 expectedSupply = 500_000 * 10 ** decimals;

        assertEq(rewardToken.totalSupply(), expectedSupply);

        assertEq(rewardToken.balanceOf(owner), expectedSupply);
    }

    function test_OtherUserHasZeroBalance() public {
        assertEq(rewardToken.balanceOf(user), 0);
    }
}
