// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console, console2} from "forge-std/Test.sol";
import "src/UniV3Arb.sol";
import "./MockToken.sol";
import "../utils/Toolkit.sol";
import "../src/interfaces/INonfungiblePositionManager.sol";

contract UniV3ArbTest is Test, Toolkit {

    MockToken token = new MockToken("TestToken", "TEST");
    INonfungiblePositionManager manager = INonfungiblePositionManager(payable(0xC36442b4a4522E871399CD717aBDD847Ab11FE88));
    ISwapRouter public constant router = ISwapRouter(0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45);

    address usdce = 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8;
    address usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
    address usdt = 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9;
    address weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
    address arb = 0x912CE59144191C1204E64559FE8253a0e49E6548;
    address gmx = 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a;
    address wbtc = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;
    address wstEth = 0x5979D7b546E38E414F7E9822514be443A4800529;
    address link = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;

    address[] tokens = [usdce, usdc, usdt, weth, arb, gmx, wbtc, wstEth, link];
    function setUp() public {
        token.approve(address(router), type(uint256).max);
        token.approve(address(manager), type(uint256).max);
        token.mint(address(this), 100000000 * 10**18);
        uint24 fee = 50;

        for (uint256 i = 0; i < tokens.length; i++) {
            uint160 sqrtPriceX96 = encodePriceSqrt(1, 18);
            manager.createAndInitializePoolIfNecessary(address(token), tokens[i], fee, sqrtPriceX96);
        }
    }

}
