//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {BaseTest} from "../../Base.t.sol";

contract EmergencyWithdrawTest is BaseTest {
    function testEmergencyWithdrawSuccessful() public {}

    function testEmergencyWithdrawWithNoStake() public {}

    function testEmergencyWithdrawLosesPendingRewards() public {}

    function testEmergencyWithdrawResetsUserData() public {}

    function testEmergencyWithdrawDecreasesTotalStaked() public {}

    function testEmergencyWithdrawTransfersTokensBack() public {}

    function testEmergencyWithdrawEmitsEvent() public {}

    function testEmergencyWithdrawDoesNotCallUpdatePool() public {}

    function testEmergencyWithdrawReentrancyProtection() public {}

    function testEmergencyWithdrawByMultipleUsers() public {}

    function testEmergencyWithdrawThenStakeAgain() public {}

    function testEmergencyWithdrawAfterRewardPeriodEnds() public {}

    function testEmergencyWithdrawWithMaliciousToken() public {}

    function testEmergencyWithdrawRevertsOnTransferFail() public {}
}
