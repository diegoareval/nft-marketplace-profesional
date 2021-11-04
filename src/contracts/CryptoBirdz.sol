// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721Connector.sol';

contract CryptoBirdz is ERC721Connector {
    // store nfts
    string[] public kryptoBirds;

    mapping(string => bool) _kryptoBirdsExist;

    function mint(string memory _cryptoBird) public {
        require(!_kryptoBirdsExist[_cryptoBird], 'KryptoBird already exist');
         kryptoBirds.push(_cryptoBird);
        uint _id = kryptoBirds.length -1;
        _mint(msg.sender, _id);
    _kryptoBirdsExist[_cryptoBird] = true;

    }

    constructor() ERC721Connector('KriptoBirdz', 'KBIRDZ'){
    }
}

