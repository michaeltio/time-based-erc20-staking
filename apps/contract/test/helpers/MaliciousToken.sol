// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IStakingWithdraw {
    function withdraw(uint256 amount) external;
}

contract MaliciousToken is ERC20 {
    IStakingWithdraw public staking;
    address public attacker;
    bool private attacking;

    constructor(address _staking) ERC20("Malicious Token", "MAL") {
        staking = IStakingWithdraw(_staking);
    }

    function setAttacker(address _attacker) external {
        attacker = _attacker;
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    // function _update(
    //     address from,
    //     address to,
    //     uint256 value
    // ) internal override {
    //     super._update(from, to, value);

    //     if (!attacking && from == address(staking) && to == attacker) {
    //         attacking = true;
    //         staking.withdraw(10);
    //     }
    // }
}
