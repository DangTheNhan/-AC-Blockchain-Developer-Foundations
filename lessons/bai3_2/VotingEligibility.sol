// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingEligibility {
    uint public minAge = 18;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function checkEligibility(uint age) public pure returns (bool) {
        if (age >= 18) {
            return true;
        } else {
            return false;
        }
    }

    function updateMinAge(uint newMinAge) public {
        require(msg.sender == owner, "Only owner can update");
        minAge = newMinAge;
    }
}
