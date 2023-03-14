/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyTokenNFT21 is ERC721, AccessControl, Pausable {
    using Counters for Counters.Counter;
    enum Role {ADMIN, VIP, WHITELIST}
    mapping(address => Role) private roles;


    //Create roles
    bytes32 public constant VIP_ROLE = keccak256("VIP_ROLE");
    bytes32 public constant WHITELIST_ROLE = keccak256("WHITELIST_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    uint256 public constant MAX_SUPPLY = 5;
    bytes32 public constant TOKEN_NAME="TOKEN";
    //token created tracker
    Counters.Counter private _tokenIds;
    uint256 public prixNFT = 1 ether;
    uint256 public constant VIP_PRICE = 0.5 ether;
    uint256 public constant NORMAL_PRICE = 1 ether;


    constructor() ERC721("MyTokenNFT21", "MyNFT") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(VIP_ROLE, msg.sender);
        _setupRole(WHITELIST_ROLE, msg.sender);
        _setupRole(ADMIN_ROLE, msg.sender);

    }

    function createNFT(address to) public returns (uint256) {
        require(_tokenIds.current() < MAX_SUPPLY, "The number max of supply is reached");
        //generate new token
        uint256 newTokenId = _tokenIds.current() + 1;
        _safeMint(to, newTokenId);
        _setTokenURI(newTokenId, TOKEN_NAME);
        _tokenIds.increment();
        return newTokenId;
    }


    function buy() public payable {
        sender_adress = msg.sender;
        if (hasRole(ADMIN_ROLE, msg.sender)) {
            // l'admin peut acheter gratuitement un NFT
            uint256 _tokenId = createNFT(sender_adress);
            _safeTransfer(ownerOf(_tokenId), sender_adress, _tokenId, "");
        } else if (hasRole(VIP_ROLE, sender_adress)) {
            // les VIP peuvent acheter un NFT à un prix avantageux
            require(msg.value >= VIP_PRICE, "Le montant envoye n'est pas suffisant pour un VIP");
             uint256 _tokenId = createNFT(sender_adress);
            _safeTransfer(ownerOf(_tokenId), sender_adress, _tokenId, "");
        } else if (hasRole(WHITELIST_ROLE, sender_adress)) {
            // les personnes sur la liste blanche peuvent acheter un NFT au prix normal
            require(msg.value >= NORMAL_PRICE, "Le montant envoye n'est pas suffisant pour un NFT normal");
            uint256 _tokenId = createNFT(sender_adress);
            _safeTransfer(ownerOf(_tokenId), sender_adress, _tokenId, "");
        } else {
            revert("Vous n'avez pas le role pour acheter un NFT");
        }
    }

    function addToWhitelist(address _address) public onlyRole(ADMIN_ROLE) {
        grantRole(WHITELIST_ROLE, _address);
    }

    function addToVIP(address _address) public onlyRole(ADMIN_ROLE) {
        grantRole(VIP_ROLE, _address);
    }

    function banAdmin(address _address) public onlyRole(ADMIN_ROLE) {
        revokeRole(ADMIN_ROLE, _address);
    }

    function banVIP(address _address) public onlyRole(ADMIN_ROLE) {
        revokeRole(VIP_ROLE, _address);
    }

    function banWhitelist(address _address) public onlyRole(ADMIN_ROLE) {
        revokeRole(WHITELIST_ROLE, _address);
    }

    function pauseContract() public onlyRole(ADMIN_ROLE) {
        _pause();
    }
    
   
}
