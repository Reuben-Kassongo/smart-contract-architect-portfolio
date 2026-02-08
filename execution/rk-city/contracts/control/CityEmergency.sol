// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Pausable} from "openzeppelin-contracts/contracts/utils/Pausable.sol";
import {CityRoles} from "./CityRoles.sol";

abstract contract CityEmergency is CityRoles, Pausable {
    constructor(address admin) CityRoles(admin) {}

    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }
}
