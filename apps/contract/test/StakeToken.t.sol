//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import "forge-std/Test.sol";
import "./StakeToken.sol";

contract StakeTokenTest is Test {
    StakeToken stakeToken;
    address owner;
    address user;

    function setUp() public {
        owner = address(this);
        user = address(0x123);

        stakeToken = new StakeToken();
    }

    function test_NameAndSymbol() public {
        assertEq(stakeToken.name(), "StakeToken");
        assertEq(stakeToken.symbol(), "SKT");
    }

    function test_MintAmountToOwner() public {
        uint256 decimals = stakeToken.decimals();
        uint256 expectedSupply = 1_000_000 * 10 ** decimals;

        assertEq(stakeToken.totalSupply(), expectedSupply);

        assertEq(stakeToken.balanceOf(owner), expectedSupply);
    }

    function test_OtherUserHasZeroBalance() public {
        assertEq(stakeToken.balanceOf(user), 0);
    }
}
