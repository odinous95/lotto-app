// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {Lotto} from "../../src/Lotto.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {LottoDeploy} from "../../script/LottoDeploy.s.sol";
import {console} from "forge-std/console.sol";

contract LottoTest is Test {
    Lotto public lotto;
    HelperConfig public helperConfig;
    address public USER = makeAddr("user");
    uint256 public constant STARTING_BALANCE = 10 ether;
    uint256 public entranceFee;
    uint256 public lotteryInterval;
    address public vrfCoordinator;
    bytes32 public keyHash;
    uint256 public subId;
    uint32 public callbackGasLimit;

    function setUp() external {
        LottoDeploy deployer = new LottoDeploy();
        (lotto, helperConfig) = deployer.deployContract();
        HelperConfig.NetworkConfig memory networkConfig = helperConfig.getLocalConfig();
        entranceFee = networkConfig.entranceFee;
        lotteryInterval = networkConfig.lotteryInterval;
        vrfCoordinator = networkConfig.vrfCoordinator;
        keyHash = networkConfig.keyHash;
        subId = networkConfig.subId;
        callbackGasLimit = networkConfig.callbackGasLimit;
    }

    function testLottoEntrence() public {
        entranceFee = lotto.getEntranceFee();
        console.log("Entrance fee is:", entranceFee);
        assert(entranceFee > 0);
    }
}
