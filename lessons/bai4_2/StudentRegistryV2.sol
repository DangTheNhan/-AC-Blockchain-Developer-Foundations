// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistryV2 {
    struct Student {
        string name;
        uint age;
        bool isRegistered;
    }

    address public owner;
    mapping(address => Student) private students;

    event StudentRegistered(address indexed student, string name, uint age);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addStudent(address _student, string calldata _name, uint _age) external onlyOwner {
        students[_student] = Student({
            name: _name,
            age: _age,
            isRegistered: true
        });
        emit StudentRegistered(_student, _name, _age);
    }

    function getStudent(address user) external view returns (string memory, uint, bool) {
        Student memory s = students[user];
        return (s.name, s.age, s.isRegistered);
    }

    function isStudentRegistered(address user) external view returns (bool) {
        return students[user].isRegistered;
    }
}