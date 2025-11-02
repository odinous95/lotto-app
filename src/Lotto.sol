// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";
/**
 * @title Lotto
 * @author Odinous
 * @notice A simple lottery contract
 * @dev This contract is a placeholder for a lottery system implementation.
 */

contract Lotto is VRFConsumerBaseV2Plus {
    // Errors -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    error Lotto__NotEnoughToEnterLotto();
    error Lotto__NotEnoughTimePassed();
    error Lotto__TransferFailed();
    error Lotto__NotOpen();



    
    // Enum for the state of the lotto-=-=-=-=-=-=-=
    enum LottoState {
        OPEN,
        CALCULATING,
    }

    // State variables -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_lotto_interval; // Time interval for picking a winner in seconds
    bytes32 private immutable i_keyHash;
    uint256 private immutable i_subId;
    uint16 private constant REQUEST_CONFIRMETION = 3;
    uint32 private constant CALLBACK_GAS_LIMIT = 100000; // Gas limit for the callback function
    uint32 private constant NUM_WORDS = 1; // Number of random words to request
    uint256 private s_lastPickedTime; // Timestamp of the last winner pick (snapshot)
    address payable[] private s_players;
    address private s_recentWinner
    LottoState private s_lottoState;

    // Events -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    event LottoEntered(address indexed player);

    event WinnerPicked(address indexed winner);

    // Constructor -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    constructor(uint256 _entranceFee, uint256 _interval, address vrfCoordinator, bytes32 keyHash, uint64 subId)
        VRFConsumerBaseV2Plus(vrfCoordinator)
    {
        i_entranceFee = _entranceFee;
        i_lotto_interval = _interval;
        i_keyHash = _keyHash;
        i_subId = _subId;
        s_lastPickedTime = block.timestamp;
        s_lottoState = LottoState.OPEN;
    }

    // Lottery functions -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    /**
     * @notice Allows a user to enter the lottery by paying the entrance fee
     * @dev Reverts if the sent value is less than the entrance fee
     * Emits a LottoEntered event upon successful entry
     *
     */
    function enterLotto() public payable {
        if (msg.value < i_entranceFee) {
            revert Lotto__NotEnoughToEnterLotto();
        }
        if (s_lottoState != LottoState.OPEN) {
            revert Lotto__NotOpen();
        }
        s_players.push(payable(msg.sender));
        emit LottoEntered(msg.sender);
    }

    /**
     * @notice Picks a winner for the lottery if the time interval has passed
     * @dev Reverts if the required time interval has not passed since the last pick
     * Requests random words from Chainlink VRF
     *
     */
    function pickWinner() public {
        if (block.timestamp - s_lastPickedTime < i_lotto_interval) {
            revert Lotto__NotEnoughTimePassed();
        }
        s_lottoState = LottoState.CALCULATING;
        VRFV2PlusClient.RandomWordsRequest memory request = VRFV2PlusClient.RandomWordsRequest({
            keyHash: i_keyHash,
            subId: i_subId,
            requestConfirmations: REQUEST_CONFIRMETION,
            callbackGasLimit: CALLBACK_GAS_LIMIT,
            numWords: NUM_WORDS,
            extraArgs: VRFV2PlusClient._argsToBytes(VRFV2PlusClient.ExtraArgsV1({nativePayment: false})) // new parameter
        });
        uint256 requestId = s_vrfCoordinator.requestRandomWords(request);
    }
    // Callback function called by Chainlink VRF with the random number

    /**
     *
     * @param _requestId
     * @param _randomWords
     * @dev Uses the random words to pick a winner from the players array
     * Transfers the contract balance to the winner
     *
     */
    function fulfillRandomWords(uint256 _requestId, uint256[] calldata _randomWords) internal override {
        uint256 winnerIndex = _randomWords[0] % s_players.length;
        address payable winner = s_players[winnerIndex];
        s_lottoState = LottoState.OPEN;
        s_recentWinner = winner;
        s_players = new address payable[](0);
        s_lastPickedTime = block.timestamp;
        (bool success,) = winner.call{value: address(this).balance}("");

        if (!success) {
            revert Lotto__TransferFailed();
        }
        emit WinnerPicked(winner);
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
