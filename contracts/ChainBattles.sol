pragma solidity ^0.8.4

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";


contract ChainBattle is ERC721URIStorage{

    using String for uint256;
    using Counters for Counters.Counters;
    Counter.Counters private _tokenIds;

    mapping(uint256 => uint256) public tokenIdToLevels; 

    constructor() ERC721("Chain Battles", "CBTLS")

}