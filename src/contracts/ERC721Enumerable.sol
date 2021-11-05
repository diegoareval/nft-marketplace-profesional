// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {
    uint256[] private _allTokens;

    mapping(uint256 => uint256) private _allTokensIndex;

    mapping(address => uint256[]) private _ownedTokens;

    mapping(uint256 => uint256) private _ownedTokensIndex;


    function _mint(address to, uint256 tokenId) override(ERC721) internal {
       super._mint(to, tokenId);
        // A: add tokens to the owners
        // B: all tokens to our totalSupply
        _addTokenToTokensEnumeration(tokenId);
        _addTokenToOwnersEnumeration(to, tokenId);
    }



    function _addTokenToTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokenToOwnersEnumeration(address to, uint256 tokenId) private{
     //add address and token id to the _ownedTokens
    _ownedTokens[to].push(tokenId);

    _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
    }

    /// @notice Enumerate valid NFTs
    /// @dev Throws if `_index` >= `totalSupply()`.
    /// @param _index A counter less than `totalSupply()`
    /// @return The token identifier for the `_index`th NFT,
    ///  (sort order not specified)
    function tokenByIndex(uint256 _index) external view returns (uint256){
        require(_index < totalSupply(), 'global index is out of bounds');
         return _allTokens[_index];
    }

    /// @notice Enumerate NFTs assigned to an owner
    /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
    ///  `_owner` is the zero address, representing invalid NFTs.
    /// @param _owner An address where we are interested in NFTs owned by them
    /// @param _index A counter less than `balanceOf(_owner)`
    /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
    ///   (sort order not specified)
    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){
        require(_index < balanceOf(_owner), 'owner index is out of bounds');
        return _ownedTokens[_owner][_index];
    }

    function totalSupply() public view returns(uint256){
        return _allTokens.length;
    }
}
