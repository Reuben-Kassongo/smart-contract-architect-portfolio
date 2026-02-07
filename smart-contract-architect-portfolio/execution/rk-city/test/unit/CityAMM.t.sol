// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../contracts/core/CityAMM.sol";

contract ReenterHook is ICityAMMHook {
    CityAMM public amm;

    constructor(CityAMM _amm) {
        amm = _amm;
    }

    function onSwap() external {
        // Try to reenter during the hook. Must revert due to nonReentrant.
        amm.swapAForB(1);
    }
}

contract CityAMMTest is Test {
    CityAMM amm;

    function setUp() public {
        amm = new CityAMM();
        amm.addLiquidity(1_000 ether, 1_000 ether);
    }

    function k(uint256 x, uint256 y) internal pure returns (uint256) {
        return x * y;
    }

    function test_swap_updates_reserves_and_k_non_decreases() public {
        uint256 x0 = amm.reserveA();
        uint256 y0 = amm.reserveB();
        uint256 k0 = k(x0, y0);

        uint256 dx = 100 ether;
        uint256 dy = amm.swapAForB(dx);

        uint256 x1 = amm.reserveA();
        uint256 y1 = amm.reserveB();
        uint256 k1 = k(x1, y1);

        // Reserve consistency (internal accounting)
        assertEq(x1, x0 + dx, "reserveA not updated");
        assertEq(y1, y0 - dy, "reserveB not updated");

        // With integer rounding in getAmountOut, k' should be >= k (never decreases)
        assertGe(k1, k0, "k decreased (free value leak)");
    }

    function test_no_free_output_reverts_on_zero_in_and_bounds_output() public {
        vm.expectRevert(bytes("ZERO_IN"));
        amm.swapAForB(0);

        uint256 y0 = amm.reserveB();
        uint256 dy = amm.swapAForB(1 ether);

        assertGt(dy, 0, "output should be > 0");
        assertLt(dy, y0, "output must be < reserveOut");
    }

    function test_no_stale_reserve_use_second_swap_uses_updated_reserves() public {
        // First swap
        uint256 dx1 = 100 ether;
        uint256 dy1 = amm.swapAForB(dx1);

        // Grab updated reserves
        uint256 x1 = amm.reserveA();
        uint256 y1 = amm.reserveB();

        // Expected output for second swap based on UPDATED reserves
        uint256 dx2 = 50 ether;
        uint256 expectedDy2 = amm.getAmountOut(dx2, x1, y1);

        uint256 actualDy2 = amm.swapAForB(dx2);
        assertEq(actualDy2, expectedDy2, "used stale reserves / wrong pricing");
        assertEq(amm.reserveA(), x1 + dx2, "reserveA mismatch after 2nd swap");
        assertEq(amm.reserveB(), y1 - actualDy2, "reserveB mismatch after 2nd swap");

        // (dy1 is unused except to ensure the first swap actually happened)
        assertGt(dy1, 0, "first swap output should be > 0");
    }

    function test_safe_update_order_and_reentrancy_guard_with_hook() public {
        ReenterHook hook = new ReenterHook(amm);

        // swapAForBWithHook should revert due to attempted reentrancy inside the hook
        vm.expectRevert(bytes("REENTRANCY"));
        amm.swapAForBWithHook(10 ether, address(hook));
    }
}
