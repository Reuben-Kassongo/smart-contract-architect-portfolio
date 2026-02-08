// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {CityStaking} from "../../contracts/core/CityStaking.sol";
import {CityToken} from "../../contracts/core/CityToken.sol";

contract CityStakingTest is Test {
    address ADMIN = address(0xA11CE);
    address ALICE = address(0xB0B);

    CityToken token;
    CityStaking staking;

    function setUp() public {
        token = new CityToken(
            "City Token",
            "CITY",
            ADMIN,
            1_000_000e18
        );

        staking = new CityStaking(
            ADMIN,
            address(token),
            address(token),
            1e18 // 1 token per second
        );

        // Fund staking rewards
        vm.prank(ADMIN);
        token.transfer(address(staking), 100_000e18);

        // Give Alice tokens
        vm.prank(ADMIN);
        token.transfer(ALICE, 1_000e18);

        vm.prank(ALICE);
        token.approve(address(staking), type(uint256).max);
    }

    function test_stakeAndAccrueRewards() public {
        vm.prank(ALICE);
        staking.stake(100e18);

        vm.warp(block.timestamp + 10);

        uint256 earned = staking.earned(ALICE);
        assertGt(earned, 0);
    }

    function test_claimRewards() public {
        vm.prank(ALICE);
        staking.stake(100e18);

        vm.warp(block.timestamp + 5);

        vm.prank(ALICE);
        staking.claim();

        assertGt(token.balanceOf(ALICE), 900e18);
    }

    function test_pauseBlocksStaking() public {
        vm.prank(ADMIN);
        staking.pause();

        vm.prank(ALICE);
        vm.expectRevert();
        staking.stake(100e18);
    }

    function test_withdrawWorks() public {
        vm.prank(ALICE);
        staking.stake(100e18);

        vm.prank(ALICE);
        staking.withdraw(100e18);

        assertEq(staking.staked(ALICE), 0);
    }
}
