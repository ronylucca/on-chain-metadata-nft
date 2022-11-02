//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";


contract ChainBattles is ERC721URIStorage {

    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

     struct Character{
        uint256 level;
        uint256 speed;
        uint256 strength;
        uint256 life;
    }

    mapping(uint256 => Character) public tokenIdToCharacter; 

    constructor() ERC721("Chain Battles", "CBTLS"){}

    function generateCharacter(uint256 tokenId) public view returns(string memory){


    bytes memory svg = abi.encodePacked(
        '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
        '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
        '<rect width="100%" height="100%" fill="black" />',
        '<text x="50%" y="15%" class="base" dominant-baseline="middle" text-anchor="middle">',"Warrior",'</text>',
        '<text x="50%" y="35%" class="base" dominant-baseline="middle" text-anchor="middle">', "Level: ",tokenIdToCharacter[tokenId].level.toString(),'</text>',
        '<text x="50%" y="45%" class="base" dominant-baseline="middle" text-anchor="middle">', "Speed: ",tokenIdToCharacter[tokenId].speed.toString(),'</text>',
        '<text x="50%" y="55%" class="base" dominant-baseline="middle" text-anchor="middle">', "Strength: ",tokenIdToCharacter[tokenId].strength.toString(),'</text>',
        '<text x="50%" y="65%" class="base" dominant-baseline="middle" text-anchor="middle">', "Life: ",tokenIdToCharacter[tokenId].life.toString(),'</text>',
        '</svg>'
    );
    return string(
        abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(svg)
        )    
    );
}


    function getTokenURI(uint256 tokenId) public view returns (string memory){
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "Chain Battles #', tokenId.toString(), '",',
                '"description": "Battles on chain",',
                '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }
    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenIdToCharacter[newItemId] = Character(random(100),random(50),random(1000),random(250));
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existing token");
        require(ownerOf(tokenId) == msg.sender, "You must own this token to train it");
        tokenIdToCharacter[tokenId].level = tokenIdToCharacter[tokenId].level + 1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }

    function random(uint number) public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,  
        msg.sender))) % number;
    }

}