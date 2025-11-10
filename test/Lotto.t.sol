// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {Lotto} from "../src/Lotto.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";
import {LottoDeploy} from "../script/LottoDeploy.s.sol";

contract LottoTest is Test {
    Lotto public lotto;
    HelperConfig public helperConfig;

    function setUp() external {
        LottoDeploy deployer = new LottoDeploy();
        (lotto, helperConfig) = deployer.deployContract();
    }
}
