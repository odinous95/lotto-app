// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Lotto
 * @author Odinous
 * @notice A simple lottery contract
 * @dev This contract is a placeholder for a lottery system implementation.
 */
contract Lotto {
    // State variables -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    uint256 private immutable i_entranceFee;

    // Constructor -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    constructor(uint256 _entranceFee) {
        i_entranceFee = _entranceFee;
    }

    // Lottery functions -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    function enterLotto() public payable {
        // Implementation goes here
    }
    function pickWinner() public {
        // Implementation goes here
    }

    // Getter functions -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    /**
     * @notice Returns the entrance fee for the lottery
     * @return The entrance fee in wei
     */
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
