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

    // Events -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    event LottoEntered(address indexed player);

    // Constructor -=-=-=-=-=-=-=-------=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    constructor(uint256 _entranceFee, uint256 _interval, address vrfCoordinator, bytes32 keyHash, uint64 subId)
        VRFConsumerBaseV2Plus(vrfCoordinator)
    {
        i_entranceFee = _entranceFee;
        i_lotto_interval = _interval;
        i_keyHash = _keyHash;
        i_subId = _subId;
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
        VRFV2PlusClient.RandomWordsRequest request = VRFV2PlusClient.RandomWordsRequest({
            keyHash: i_keyHash,
            subId: i_subId,
            requestConfirmations: REQUEST_CONFIRMETION,
            callbackGasLimit: CALLBACK_GAS_LIMIT,
            numWords: NUM_WORDS,
            extraArgs: VRFV2PlusClient._argsToBytes(VRFV2PlusClient.ExtraArgsV1({nativePayment: false})) // new parameter
        });
        uint256 requestId = s_vrfCoordinator.requestRandomWords(request);
    }

    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal override {
        // Implementation for selecting a winner using randomWords
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
