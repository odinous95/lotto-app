// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";

abstract contract LocalChainConstants {
    uint256 public constant LOCAL_NETWORK_ID = 31337;
    uint256 public constant ENTERANCE_FEE = 0.1 ether;
    uint256 public constant LOTTERY_INTERVAL = 300; // 5 minutes
    uint32 public constant CALLBACK_GAS_LIMIT = 100000;
}

contract HelperConfig is Script, LocalChainConstants {
    struct NetworkConfig {
        uint256 entranceFee;
        uint256 lotteryInterval;
        address vrfCoordinator;
        bytes32 keyHash;
        uint64 subId;
        uint32 callbackGasLimit;
    }

    NetworkConfig public localNetworkConfig;

    constructor() {
        localNetworkConfig = NetworkConfig({
            entranceFee: ENTERANCE_FEE,
            lotteryInterval: LOTTERY_INTERVAL,
            vrfCoordinator: VRF_COORDINATOR,
            keyHash: KEY_HASH,
            subId: SUB_ID,
            callbackGasLimit: CALLBACK_GAS_LIMIT
        });
    }

    function getLocalConfig() public view returns (NetworkConfig memory) {
        return localNetworkConfig;
    }
}
