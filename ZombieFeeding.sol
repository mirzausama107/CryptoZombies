// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

contract ZombieFeeding is ZombieFactory{
    import "./ZombieFactory.sol";

    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);  // only the onwer can feed the zombie

        Zombie storage myZombie = zombies[_zombieId];  // pointer for zombie in the blockchain
        _targetDna = _targetDna % dnaModulus; // to make sure target dna is not longer than 16 digits

        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("Usama", newDna);
    }
}   