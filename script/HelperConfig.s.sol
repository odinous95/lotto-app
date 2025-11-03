// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Lotto} from "../src/Lotto.sol";

contract HelperConfig is Script {
    LOCAL_NETWORK_ID = 31337;
    ENTERCENCE_FEE = 0.1 ether;
    LOTTERY_INTERVAL = 300; // 5 minutes
    CALLBACK_GAS_LIMIT = 100000;

    struct NetworkConfig = {
        uint256 entranceFee;
        uint256 lotteryInterval;
        address vrfCoordinator;
        bytes32 keyHash;
        uint64 subId;
        uint32 callbackGasLimit 
    }

    NetworkConfig public localNetworkConfig;
    mapping (uint256 chainId => NetworkConfig) public networkConfigs;
    constructor() {
        networkConfigs[LOCAL_NETWORK_ID] = getSepoliaETHConfig();
    }
    function getSepoliaETHConfig() public pure returns (NetworkConfig memory) {
        networkConfigs[LOCAL_NETWORK_ID] = NetworkConfig({
            entranceFee: ENTERCENCE_FEE,
            lotteryInterval: LOTTERY_INTERVAL,
            vrfCoordinator: 0x... , // Local VRF Coordinator address
            keyHash: 0x... , // Local key hash
            subId: 1, // Local subscription ID
            callbackGasLimit: CALLBACK_GAS_LIMIT
        });
    }
}
