// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Lotto
 * @author Odinous
 * @notice A simple lottery contract
 * @dev This contract is a placeholder for a lottery system implementation.
 */
contract Lotto {
    uint256 private immutable i_entranceFee;

    constructor(uint256 _entranceFee) {
        i_entranceFee = _entranceFee;
    }

    function enterLotto() public payable {
        // Implementation goes here
    }
    function pickWinner() public {
        // Implementation goes here
    }

    // Getter functions

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
