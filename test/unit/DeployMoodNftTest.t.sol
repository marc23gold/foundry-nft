//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test{

    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testSvgToImageUriWorks() public  {
        //arrange
        string memory expectedURI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSAiMCIgeSA9ICIxNSJmaWxsID0gImJsYWNrIj4gSGkhIFlvdSBkaWQgaXQhIDwvdGV4dD48L3N2Zz4=";
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x= "0" y = "15"fill = "black"> Hi! You did it! </text></svg>';
        //act
        string memory actualUri = deployer.svgToImageURI(svg);
        //assert
        assert(keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedURI)));
    }
}