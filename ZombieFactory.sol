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

    function _createZombie(string memory _name, uint _dna) public { 
        zombies.push(Zombie(_name, _dna)); // Push the zombie into the array
        uint id = zombies.length - 1;      // Get the index of the newly created zombie
        emit NewZombie(id, _name, _dna);   // Emit the event with the zombie ID
    }

    function generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnamodulus;
    }
}
