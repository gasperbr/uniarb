// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {UniV3Arb} from "src/UniV3Arb.sol";

contract CounterScript is Script {
    address tradeToken = 0x3082CC23568eA640225c2467653dB90e9250AaA0;
    UniV3Arb arbContract;

    address usdce = 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8;
    address usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
    address usdt = 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9;
    address weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
    address arb = 0x912CE59144191C1204E64559FE8253a0e49E6548;
    address gmx = 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a;
    address wbtc = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;
    address wstEth = 0x5979D7b546E38E414F7E9822514be443A4800529;
    address link = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;

    address[] tokensA;
    address[] tokensB;
    bytes[] paths;

    function run() public {
        vm.broadcast();
        deploy();
    }

    function deploy() public {
        arbContract = new UniV3Arb(tradeToken);
        console2.log("Deployed UniV3Arb at address: ", address(arbContract));

        uint24 _100 = uint24(100);
        uint24 _500 = uint24(500);
        uint24 _10000 = uint24(10000);

        _storePath(tradeToken, usdce, abi.encode(_10000));
        _storePath(tradeToken, usdc, abi.encode(_10000));
        _storePath(tradeToken, usdt, abi.encode(_10000));
        _storePath(tradeToken, weth, abi.encode(_10000));
        _storePath(tradeToken, arb, abi.encode(_10000));
        _storePath(tradeToken, gmx, abi.encode(_10000));
        _storePath(tradeToken, wbtc, abi.encode(_10000));
        _storePath(tradeToken, wstEth, abi.encode(_10000));
        _storePath(tradeToken, link, abi.encode(_10000));

        _storePath(usdce, usdc, abi.encode(_100));
        _storePath(usdce, usdt, abi.encode(_100));
        _storePath(usdce, weth, abi.encode(_500));
        _storePath(usdce, arb, abi.encode(_500));
        _storePath(usdce, gmx, abi.encode(_500));
        _storePath(usdce, wbtc, abi.encode(_500));
        _storePath(usdce, wstEth, abi.encode(_500, weth, _100));
        _storePath(usdce, link, abi.encode(_500, weth, _500));

        _storePath(usdce, usdc, abi.encode(_100));
        _storePath(usdce, usdt, abi.encode(_100));
        _storePath(usdce, weth, abi.encode(_500));
        _storePath(usdce, arb, abi.encode(_500));
        _storePath(usdce, gmx, abi.encode(_500));
        _storePath(usdce, wbtc, abi.encode(_500));
        _storePath(usdce, wstEth, abi.encode(_500, weth, _100));
        _storePath(usdce, link, abi.encode(_500, weth, _500));

        _storePath(usdc, usdt, abi.encode(_100));
        _storePath(usdc, weth, abi.encode(_500));
        _storePath(usdc, arb, abi.encode(_100, usdce, _500));
        _storePath(usdc, gmx, abi.encode(_100, usdce, _500));
        _storePath(usdc, wbtc, abi.encode(_500));
        _storePath(usdc, wstEth, abi.encode(_500, weth, _100));
        _storePath(usdc, link, abi.encode(_500, weth, _500));

        _storePath(usdt, weth, abi.encode(_500));
        _storePath(usdt, arb, abi.encode(_500));
        _storePath(usdt, gmx, abi.encode(_100, usdce, _500));
        _storePath(usdt, wbtc, abi.encode(_500, weth, _500));
        _storePath(usdt, wstEth, abi.encode(_500, weth, _100));
        _storePath(usdt, link, abi.encode(_500, weth, _500));

        _storePath(weth, arb, abi.encode(_500));
        _storePath(weth, gmx, abi.encode(_500));
        _storePath(weth, wbtc, abi.encode(_500));
        _storePath(weth, wstEth, abi.encode(_100));
        _storePath(weth, link, abi.encode(_500));

        _storePath(arb, gmx, abi.encode(_500, weth, _500));
        _storePath(arb, wbtc, abi.encode(_500, weth, _500));
        _storePath(arb, wstEth, abi.encode(_500, weth, _100));
        _storePath(arb, link, abi.encode(_500, weth, _500));

        _storePath(gmx, wbtc, abi.encode(_500, weth, _500));
        _storePath(gmx, wstEth, abi.encode(_500, weth, _100));
        _storePath(gmx, link, abi.encode(_500, weth, _500));

        _storePath(wbtc, wstEth, abi.encode(_500, weth, _100));
        _storePath(wbtc, link, abi.encode(_500, weth, _500));
        
        _storePath(wstEth, link, abi.encode(_100, weth, _500));

        arbContract.setTokenPairPath(tokensA, tokensB, paths);
    }
    
    function _storePath(address tokenA, address tokenB, bytes memory path) internal {
        tokensA.push(tokenA);
        tokensB.push(tokenB);
        paths.push(path);
    }

}
