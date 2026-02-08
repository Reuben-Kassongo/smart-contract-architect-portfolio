// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Optional hook to simulate an external call during swap (reentrancy surface).
interface ICityAMMHook {
    function onSwap() external;
}

/// @notice Minimal constant-product AMM used for Phase 3 invariant proofs.
/// NOTE: This AMM is purpose-built for proofs (reserves + math), not production token transfers.
contract CityAMM {
    uint256 public reserveA;
    uint256 public reserveB;

    bool private _locked;

    event LiquidityAdded(address indexed provider, uint256 amountA, uint256 amountB, uint256 newReserveA, uint256 newReserveB);
    event Swap(
        address indexed trader,
        bool indexed aForB,
        uint256 amountIn,
        uint256 amountOut,
        uint256 newReserveA,
        uint256 newReserveB
    );

    modifier nonReentrant() {
        require(!_locked, "REENTRANCY");
        _locked = true;
        _;
        _locked = false;
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external {
        require(amountA > 0 && amountB > 0, "ZERO_LIQ");
        reserveA += amountA;
        reserveB += amountB;
        emit LiquidityAdded(msg.sender, amountA, amountB, reserveA, reserveB);
    }

    /// @dev dy = (dx * y) / (x + dx). Integer rounding makes k' >= k.
    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) public pure returns (uint256 amountOut) {
        require(amountIn > 0, "ZERO_IN");
        require(reserveIn > 0 && reserveOut > 0, "NO_LIQ");
        amountOut = (amountIn * reserveOut) / (reserveIn + amountIn);
    }

    function swapAForB(uint256 amountIn) external nonReentrant returns (uint256 amountOut) {
        amountOut = getAmountOut(amountIn, reserveA, reserveB);
        require(amountOut > 0 && amountOut < reserveB, "BAD_OUT");

        // Update reserves BEFORE any external interaction (there is none in this basic swap)
        reserveA += amountIn;
        reserveB -= amountOut;

        emit Swap(msg.sender, true, amountIn, amountOut, reserveA, reserveB);
    }

    function swapBForA(uint256 amountIn) external nonReentrant returns (uint256 amountOut) {
        amountOut = getAmountOut(amountIn, reserveB, reserveA);
        require(amountOut > 0 && amountOut < reserveA, "BAD_OUT");

        reserveB += amountIn;
        reserveA -= amountOut;

        emit Swap(msg.sender, false, amountIn, amountOut, reserveA, reserveB);
    }

    /// @notice Swap with a hook call AFTER reserves update to prove "no output-before-update" + reentrancy protection.
    function swapAForBWithHook(uint256 amountIn, address hook) external nonReentrant returns (uint256 amountOut) {
        amountOut = getAmountOut(amountIn, reserveA, reserveB);
        require(amountOut > 0 && amountOut < reserveB, "BAD_OUT");

        // Critical ordering: update state first
        reserveA += amountIn;
        reserveB -= amountOut;

        // External interaction only after state is consistent
        if (hook != address(0)) {
            ICityAMMHook(hook).onSwap();
        }

        emit Swap(msg.sender, true, amountIn, amountOut, reserveA, reserveB);
    }
}
