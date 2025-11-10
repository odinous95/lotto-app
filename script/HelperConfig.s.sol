// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";

abstract contract LocalChainConstants {
    uint256 public constant LOCAL_NETWORK_ID = 31337;
    uint256 public constant SEPOLIA_TESTNET_NETWORK_ID = 11155111;
    uint256 public constant ENTERANCE_FEE = 0.1 ether;
    uint256 public constant LOTTERY_INTERVAL = 30;
    uint32 public constant CALLBACK_GAS_LIMIT = 100000;
    address public constant VRF_COORDINATOR = ;
    uint256 public constant SUB_ID = ;
    bytes32 public constant KEY_HASH = ;
}

contract HelperConfig is Script, LocalChainConstants {
    struct NetworkConfig {
        uint256 entranceFee;
        uint256 lotteryInterval;
        address vrfCoordinator;
        bytes32 keyHash;
        uint256 subId;
        uint32 callbackGasLimit;
    }

    NetworkConfig public localNetworkConfig;
    mapping(uint256 => chainID) public activeNetworkConfigs;



    constructor() {
        activeNetworkConfigs[SEPOLIA_TESTNET_NETWORK_ID] = getSepoliaETHConfig();
    }

    function getActiveConfig() public view returns (NetworkConfig memory) {
        if(activeNetworkConfigs[chainID].vrfCoordinator != address(0)) {
            return activeNetworkConfigs[chainID];
        } else if (chainID == LOCAL_NETWORK_ID) {
            return localNetworkConfig;
        }else {
            revert("No network config found for the current chain ID");
        }
   
    }

    function getSepoliaETHConfig() public view returns (NetworkConfig memory) {
        return NetworkConfig({
            entranceFee: 0.01 ether,
            lotteryInterval: 300,
            vrfCoordinator: 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625,
            keyHash: 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c,
            subId: 0,
            callbackGasLimit: 500000
        }); ;
    }

    function getLocalConfig() public view returns (NetworkConfig memory) {
        
    }
}
