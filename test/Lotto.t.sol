// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {Lotto} from "../src/Lotto.sol";

contract LottoTest is Test {
    Lotto private lotto;
    uint256 private constant ENTRANCE_FEE = 0.1 ether;

    function setUp() public {
        lotto = new Lotto(ENTRANCE_FEE);
    }

    function testGetEntranceFee() public {
        uint256 fee = lotto.getEntranceFee();
        assertEq(fee, ENTRANCE_FEE, "Entrance fee should match the initialized value");
    }
}
