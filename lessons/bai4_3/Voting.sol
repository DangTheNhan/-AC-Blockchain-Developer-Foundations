// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public owner;
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint public candidateCount;

    event CandidateAdded(uint indexed candidateId, string name);
    event Voted(address indexed voter, uint indexed candidateId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string calldata _name) external onlyOwner {
        candidateCount += 1;
        candidates[candidateCount] = Candidate({
            name: _name,
            voteCount: 0
        });
        emit CandidateAdded(candidateCount, _name);
    }

    function vote(uint _candidateId) external {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount += 1;

        emit Voted(msg.sender, _candidateId);
    }

    function getVoteCount(uint _candidateId) external view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate");
        return candidates[_candidateId].voteCount;
    }
}