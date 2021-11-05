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



    function balanceOf(address _owner) public view returns(uint256){
        require(_owner != address (0), 'Non-Exist token');
        return _OwnedTokenCount[_owner];
    }

    // @notice finding the owner of nft
    // @dev nft assign to zero address is considered invalid
    // @param _tokenId is the identifier of a nft
    // @return the address of the owner of a nft
    function ownerOf(uint256 _tokenId) external view returns(address){
       address owner = _tokenOwner[_tokenId];
        require(owner != address (0), 'Non-Exist token');
        return owner;
    }

    function _exists(uint256 tokenId) internal view returns(bool){
        // checking the mapping of address
     address owner = _tokenOwner[tokenId];
        // return true when a owner is valid
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        // the address should not be zero
        require(to != address (0), 'ERC721 ERROR: It needs to be minted with a real Address');
        // check if the address already exists
        require(!_exists(tokenId), 'ERC21 ERROR: Token already minted');
    _tokenOwner[tokenId] = to;
    _OwnedTokenCount[to] +=1;

        emit Transfer(address(0), to, tokenId);
    }

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;


}