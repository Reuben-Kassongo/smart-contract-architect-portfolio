// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

contract CityToken is ERC20, Ownable {
    error ZeroAddress();
    error ZeroAmount();

    constructor(
        string memory name_,
        string memory symbol_,
        address owner_,
        uint256 initialSupply_
    ) ERC20(name_, symbol_) Ownable(owner_) {
        if (owner_ == address(0)) revert ZeroAddress();
        if (initialSupply_ > 0) {
            _mint(owner_, initialSupply_);
        }
    }

    function mint(address to, uint256 amount) external onlyOwner {
        if (to == address(0)) revert ZeroAddress();
        if (amount == 0) revert ZeroAmount();
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        if (amount == 0) revert ZeroAmount();
        _burn(msg.sender, amount);
    }
}
