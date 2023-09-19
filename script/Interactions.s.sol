//SPDX-License-Identifer: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "./DeployBasicNft.s.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {

    BasicNft public basicNft;
    DeployBasicNft public deployer;

    function run() external {
        address mostRecentlyDeployedAdress = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedAdress);
    }

    function mintNftOnContract(address deployed) public {
        vm.startBroadcast();
        BasicNft(deployed).mintNft("ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json");
        vm.stopBroadcast();
    }
}