// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../../src/capstone/CapstoneVault.sol";

contract DeployCapstoneVault is Script {
    function run() external returns (CapstoneVault vault) {
        uint256 pk = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(pk);
        vault = new CapstoneVault();
        vm.stopBroadcast();
    }
}
