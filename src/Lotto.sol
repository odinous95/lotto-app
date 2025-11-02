// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Lotto
 * @author Odinous
 * @notice A simple lottery contract
 * @dev This contract is a placeholder for a lottery system implementation.
 */
contract Lotto {
    // Errors -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    error Lotto__NotEnoughToEnterLotto();
    error Lotto__NotEnoughTimePassed();
    // State variables -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_lotto_interval; // Time interval for picking a winner in seconds
    address payable[] private s_players;
    uint256 private s_lastPickedTime; // Timestamp of the last winner pick (snapshot)

    // Events -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    event LottoEntered(address indexed player);

    // Constructor -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    constructor(uint256 _entranceFee, uint256 _interval) {
        i_entranceFee = _entranceFee;
        i_lotto_interval = _interval;
        s_lastPickedTime = block.timestamp;
    }

    // Lottery functions -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    function enterLotto() public payable {
        if (msg.value < i_entranceFee) {
            revert Lotto__NotEnoughToEnterLotto();
        }
        s_players.push(payable(msg.sender));
        emit LottoEntered(msg.sender);
    }

    function pickWinner() public {
        if (block.timestamp - s_lastPickedTime < i_lotto_interval) {
            revert Lotto__NotEnoughTimePassed();
        }
        // if passed we pick a winner (placeholder logic)
        // we get it from chainlink VRF
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
