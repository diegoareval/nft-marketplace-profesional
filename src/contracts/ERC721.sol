// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC165.sol';
import './interfaces/IERC721.sol';
import './libraries/Counters.sol';
import './libraries/SafeMath.sol';
// NFT to point an address
// keep track token ids
// keep track token owners addresses to token ids
// keep track how many token an owner has
// create an events that emits  transfer logs - contract address where it is being minted to, the id
contract ERC721 is  ERC165, IERC721 {
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    constructor() {
        _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^
        keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4)')));
    }

    // mapping from token id to owners
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to number of owned token
    mapping(address => Counters.Counter) private _OwnedTokenCount;

    mapping(uint256 => address) private _tokenApprovals;



    function balanceOf(address _owner) public override view returns(uint256){
        require(_owner != address (0), 'Non-Exist token');
        return _OwnedTokenCount[_owner].current();
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
      _OwnedTokenCount[to].increment();
        _tokenOwner[tokenId] = to;

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
    function transferFrom(address _from, address _to, uint256 _tokenId) public override virtual {
        require(isApprovedOrOwner(msg.sender,  _tokenId), 'it requires to be approved');
        _transferFrom(_from, _to, _tokenId);
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_to != address(0), 'Error - ERC721 Transfer to the zero address');
        require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address does not own!');
        _OwnedTokenCount[_from].decrement();
        _OwnedTokenCount[_to].increment();
        emit Transfer(_from, _to, _tokenId);
    }

    // it requires person approves is the owner, approve the address

    function approve(address _to, uint256 _tokenId) public {
        // address owner = ownerOf(_tokenId);
        address owner = _tokenOwner[_tokenId];
        require(_to!= owner, "should be owner");
        require(msg.sender == owner, 'current caller is not the owner');
        _tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
    }

    function ownerOf(uint256 _tokenId) public override view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'owner query for non-existent token');
        return owner;
    }

    function isApprovedOrOwner(address spender, uint256 _tokenId) internal view returns(bool){
        require(_exists(_tokenId), 'token does not exists');
        //address owner = ownerOf(_tokenId);
        address owner = _tokenOwner[_tokenId];
        return(spender == owner);
    }



}