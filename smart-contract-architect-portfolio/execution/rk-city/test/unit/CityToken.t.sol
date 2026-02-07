// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {CityToken} from "../../contracts/core/CityToken.sol";

contract CityTokenTest is Test {
    CityToken token;

    address OWNER = address(0xA11CE);
    address ALICE = address(0xB0B);
    address BOB   = address(0xCAFE);

    function setUp() public {
        token = new CityToken("City Token", "CITY", OWNER, 1_000 ether);
    }

    function test_constructorMintsInitialSupplyToOwner() public view {
        assertEq(token.balanceOf(OWNER), 1_000 ether);
        assertEq(token.totalSupply(), 1_000 ether);
        assertEq(token.owner(), OWNER);
    }

    function test_mint_onlyOwner() public {
        vm.prank(ALICE);
        vm.expectRevert();
        token.mint(ALICE, 100 ether);
    }

    function test_mint_revertsOnZeroAddress() public {
        vm.prank(OWNER);
        vm.expectRevert(CityToken.ZeroAddress.selector);
        token.mint(address(0), 100 ether);
    }

    function test_mint_revertsOnZeroAmount() public {
        vm.prank(OWNER);
        vm.expectRevert(CityToken.ZeroAmount.selector);
        token.mint(ALICE, 0);
    }

    function test_mint_increasesSupplyAndBalance() public {
        vm.prank(OWNER);
        token.mint(ALICE, 200 ether);
        assertEq(token.balanceOf(ALICE), 200 ether);
        assertEq(token.totalSupply(), 1_200 ether);
    }

    function test_burn_revertsOnZeroAmount() public {
        vm.prank(OWNER);
        vm.expectRevert(CityToken.ZeroAmount.selector);
        token.burn(0);
    }

    function test_burn_reducesBalanceAndSupply() public {
        vm.prank(OWNER);
        token.burn(100 ether);
        assertEq(token.balanceOf(OWNER), 900 ether);
        assertEq(token.totalSupply(), 900 ether);
    }

    function test_transfer_works() public {
        vm.prank(OWNER);
        token.transfer(ALICE, 50 ether);
        assertEq(token.balanceOf(ALICE), 50 ether);
        assertEq(token.balanceOf(OWNER), 950 ether);
    }

    function test_transferFrom_approvalFlow() public {
        vm.prank(OWNER);
        token.approve(ALICE, 60 ether);
        vm.prank(ALICE);
        token.transferFrom(OWNER, BOB, 60 ether);
        assertEq(token.balanceOf(BOB), 60 ether);
        assertEq(token.balanceOf(OWNER), 940 ether);
        assertEq(token.allowance(OWNER, ALICE), 0);
    }
}
