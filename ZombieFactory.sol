// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import "./ownable.sol";
import "./safemath.sol";

contract ZombieFactory is Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint16;
    using SafeMath16 for uint32;
    
    event NewZombie(uint zombieId, string name, uint dna);
    
    uint dnaDigit = 16;
    uint dnamodulus = 10**dnaDigit;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;

    }

    Zombie[] public zombies;

    mapping(uint => address) public zombieToOwner; // how many zombies owner has
    mapping(address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal { 
        zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime)), 0, 0) -1; // Push the zombie into the array
        uint id = zombies.length - 1;      // Get the index of the newly created zombie

        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
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


