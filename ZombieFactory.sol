// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

contract ZombieFactory{
    event NewZombie(uint zombieId, string name, uint dna);
    
    uint dnaDigit = 16;
    uint dnamodulus = 10**dnaDigit;

    struct Zombie {
        string name;
        uint dna;
        // uint health;
        // bool isAlive;
    }

    Zombie[] public zombies;

    mapping(uint => address) public zombieToOwner; // how many zombies owner has
    mapping(address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal { 
        zombies.push(Zombie(_name, _dna)); // Push the zombie into the array
        uint id = zombies.length - 1;      // Get the index of the newly created zombie

        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);   // Emit the event with the zombie ID
    }

    function generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnamodulus;
    }

    function CreateRandomZombie(string memory _name) public {

        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}


