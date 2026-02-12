// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../../src/capstone/CapstoneVault.sol";

contract DeployCapstoneVault is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        CapstoneVault vault = new CapstoneVault();

        vm.stopBroadcast();
    }
}
