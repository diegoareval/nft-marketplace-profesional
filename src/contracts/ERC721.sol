// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// NFT to point an address
// keep track token ids
// keep track token owners addresses to token ids
// keep track how many token an owner has
// create an events that emits  transfer logs - contract address where it is being minted to, the id
contract ERC721 {
     event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    // mapping from token id to owners
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to number of owned token
    mapping(address => uint256) private _OwnedTokenCount;

    function _exists(uint256 tokenId) internal view returns(bool){
        // checking the mapping of address
     address owner = _tokenOwner[tokenId];
        // return true when a owner is valid
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal {
        // the address should not be zero
        require(to != address (0), 'ERC721 ERROR: It needs to be minted with a real Address');
        // check if the address already exists
        require(!_exists(tokenId), 'ERC21 ERROR: Token already minted');
    _tokenOwner[tokenId] = to;
    _OwnedTokenCount[to] +=1;

        emit Transfer(address(0), to, tokenId);
    }

}