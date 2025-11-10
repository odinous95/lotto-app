// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

abstract contract LocalChainConstants {
    uint256 public constant LOCAL_NETWORK_ID = 31337;
    uint256 public constant SEPOLIA_TESTNET_NETWORK_ID = 11155111;
    // Mock VRFCoordinator parameters
    uint96  public constant MOCK_BASE_FEE = 0.1 ether;
    uint96  public constant MOCK_GAS_PRICE_LINK = 0.1 ether;
    int256  public constant MOCK_WEI_PER_UNIT_LINK = 1e18; 
    // Local network parameters
    uint256 public constant ENTERANCE_FEE = 0.1 ether;
    uint256 public constant LOTTERY_INTERVAL = 30;
    uint32 public constant CALLBACK_GAS_LIMIT = 100000;
    address public constant VRF_COORDINATOR = address(0); ;
    uint256 public constant SUB_ID =0 ;
    bytes32 public constant KEY_HASH = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15; ;
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

    function getActiveConfigByChainID() public view returns (NetworkConfig memory) {
        if(activeNetworkConfigs[chainID].vrfCoordinator != address(0)) {
            return activeNetworkConfigs[chainID];
        } else if (chainID == LOCAL_NETWORK_ID) {
            return localNetworkConfig;
        }else {
            revert("No network config found for the current chain ID");
        }
    }
    function getActiveConfig() public view returns (NetworkConfig memory) {
            return getActiveConfigByChainID((block.chainid);
    }

// Sepolia ETH Testnet Config
    function getSepoliaETHConfig() public view returns (NetworkConfig memory) {
        return NetworkConfig({
            entranceFee: 0.01 ether,
            lotteryInterval: 300,
            vrfCoordinator: 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B,
            keyHash: 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae,
            subId: 0,
            callbackGasLimit: 40000
        }); ;
    }

// Local Network Config
    function getlocalNetworkConfig() public view returns (NetworkConfig memory) {
        if(localNetworkConfig.vrfCoordinator != address(0)) {
            return localNetworkConfig;
        }
        vm.startBroadcast();
        VRFCoordinatorV2_5Mock vrfCoordinatorV2_5Mock = new VRFCoordinatorV2_5Mock(
            MOCK_BASE_FEE,
            MOCK_GAS_PRICE_LINK,
            MOCK_WEI_PER_UNIT_LINK
        );
        localNetworkConfig = NetworkConfig({
            entranceFee: ENTERANCE_FEE,
            lotteryInterval: LOTTERY_INTERVAL,
            vrfCoordinator: address(vrfCoordinatorV2_5Mock),
            keyHash: KEY_HASH,
            subId: SUB_ID,
            callbackGasLimit: CALLBACK_GAS_LIMIT
        });
        vm.stopBroadcast();
    }
}
