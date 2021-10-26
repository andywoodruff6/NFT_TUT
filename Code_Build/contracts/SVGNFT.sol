// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SVG tuturial
/// @author The New Badger
/// @notice Takes a SVG and mints an NFT all on chain
/// @dev encodes the SVG as a string and stores it in the contract


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";

contract SVGNFT is ERC721URIStorage {

    // VARIABLES
    uint256 public tokenCounter;

    // EVENTS
    event CreatedSVGNFT(uint256 indexed tokenId, string tokenURI);


    constructor() ERC721("SVG NFT", "svgNFT") {
        tokenCounter = 0;
    }

    function create(string memory _svg) public {
        _safeMint(msg.sender, tokenCounter);
        string memory imageURI = svgToImageURI(_svg);
        string memory tokenURI = formatTokenURI(imageURI);
        _setTokenURI(tokenCounter, tokenURI);
        emit CreatedSVGNFT(tokenCounter, tokenURI);
        tokenCounter += 1;
    }

    function svgToImageURI(string memory _svg) public pure returns (string memory){
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(_svg))));
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
        return imageURI;
    }
    function formatTokenURI(string memory _imageURI) public pure returns (string memory)
    {
        string memory baseURL = "data:application/json;base64,";
        return string(abi.encodePacked(baseURL,
            Base64.encode(
                bytes(abi.encodePacked(
                    '{"name":"SVG NFT",'
                    '"description":"An NFT based on an svg",'
                    '"attributes": "",'
                    '"image": "',_imageURI, '"}'
                ))
            )
        ));
    }    
        
    //     string memory imageURI = svgToImageURI(svg);
    //     return imageURI;
    // }
}