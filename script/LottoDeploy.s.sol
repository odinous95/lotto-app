// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Lotto} from "../src/Lotto.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract LottoDeploy is Script {
    function run() external {}

    function deployContract() external returns (Lotto, HelperConfig) {}
}
