// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Lotto} from "../src/Lotto.sol";

contract LottoDeploy is Script {
    function run() external {
        uint256 entranceFee = 0.1 ether;

        vm.startBroadcast();
        Lotto lotto = new Lotto(entranceFee);
        vm.stopBroadcast();
    }
}
