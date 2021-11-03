// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721Connector.sol';

contract CryptoBirdz is ERC721Connector {

    constructor() ERC721Connector('KriptoBirdz', 'KBIRDZ'){
    }
}

