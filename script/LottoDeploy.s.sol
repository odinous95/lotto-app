// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Lotto} from "../src/Lotto.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract LottoDeploy is Script {
    function run() public {}

    function deployContract() external returns (Lotto, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        HelperConfig.NetworkConfig memory networkConfig = helperConfig.getLocalConfig();

        vm.startBroadcast();
        Lotto lotto = new Lotto(
            networkConfig.entranceFee,
            networkConfig.lotteryInterval,
            networkConfig.vrfCoordinator,
            networkConfig.keyHash,
            networkConfig.subId,
            networkConfig.callbackGasLimit
        );
        vm.stopBroadcast();

        return (lotto, helperConfig);
    }
}
