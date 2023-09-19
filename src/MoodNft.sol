// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import { ERC721 } from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import { Base64 } from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {

    error OnlyOwnerCanCallThis();

    uint256 private s_tokenCounter;
    string private s_sadSvg;
    string private s_happySvg;
    address private immutable i_owner;

    enum Mood {
        Sad,
        Happy}

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSvgImageURI, string memory happySvgImageURI) ERC721("MoodNft", "Mood") {
        s_tokenCounter = 0;
        s_sadSvg = sadSvgImageURI;
        s_happySvg = happySvgImageURI;
        i_owner = msg.sender;
    }

    /**
     * @dev Mint a new NFT
     * @notice This funct
     */

    modifier onlyOwner {
        if(msg.sender != i_owner) {
            revert OnlyOwnerCanCallThis();
        }
        _;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.Sad;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        
    }

    function _baseURI() internal view override onlyOwner returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {

        string memory imageURI;
        if(s_tokenIdToMood[tokenId] == Mood.Sad) {
            imageURI = s_sadSvg;
        } else {
            imageURI = s_happySvg;
        }
    return 
    string(
    abi.encodePacked(
    _baseURI(),
    Base64.encode(
       bytes(abi.encodePacked('{"name": "', name(), '", "description": "A sad and happy face for you", "attributes": [{"trait_type": "moodiness", "value":100}], "image   ": "', imageURI, '"}'))
    )
    )
    );
        
    }

    //Getter Functions
    /**
     * uint256 private s_tokenCounter;
    *string private s_sadSvg;
    *string private s_happySvg;
    *address private immutable i_owner;
     */

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
    function getSadSvg() external view returns (string memory) {
        return s_sadSvg;
    }
    function getHappySvg() external view returns (string memory) {
        return s_happySvg;
    }
    function getOwner() external view returns (address) {
        return i_owner;
    }

}
