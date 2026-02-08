// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CityGuards} from "./CityGuards.sol";

contract MockGuardedVault is CityGuards {
    uint256 public value;

    constructor(address admin) CityGuards(admin) {}

    function setValue(uint256 v) external onlyOperator guarded {
        value = v;
    }

    function increment() external guarded nonReentrant {
        // Effects
        value += 1;

        // Interactions
    }
}
