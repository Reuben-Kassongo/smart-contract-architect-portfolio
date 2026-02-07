// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {CityEmergency} from "./CityEmergency.sol";

abstract contract CityGuards is CityEmergency, ReentrancyGuard {
    constructor(address admin) CityEmergency(admin) {}

    modifier onlyOperator() {
        _checkRole(OPERATOR_ROLE);
        _;
    }

    modifier guarded() {
        _requireNotPaused();
        _;
    }
}
