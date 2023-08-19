// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {Owned} from "solmate/auth/Owned.sol";
import {ISwapRouter} from "./interfaces/ISwapRouter.sol";

contract UniV3Arb is Owned(msg.sender) {

    ISwapRouter public constant swapRouter = ISwapRouter(0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45);
    address public immutable startingToken;

    // Returns the uni v3 path for swapping from tokenA to tokenB
    // Can be just a uint24 fee to swap tokenA to tokenB or can be a path with an intermediate token
    mapping(address tokenA => mapping(address tokenB => bytes path)) public pairPath;

    constructor(address _startingToken) {
        startingToken = _startingToken;
        ERC20(startingToken).approve(address(swapRouter), type(uint256).max);
    }

    function setTokenPairPath(address[] memory tokensA, address[] memory tokensB, bytes[] memory paths) public onlyOwner {
        for(uint256 i = 0; i < tokensA.length; i++) {
            _setTokenPairPath(tokensA[i], tokensB[i], paths[i]);
        }
    }

    function swap(address tokenA, address tokenB, uint256 amountIn, uint256 amountOutMin) external onlyOwner {
        _swap(_constructPath(tokenA, tokenB), amountIn, amountOutMin);
    }

    // Swap X > A > ... > B > X
    function _constructPath(address tokenA, address tokenB) internal view returns (bytes memory path) {
        return abi.encodePacked(
            startingToken,
            pairPath[startingToken][tokenA],
            tokenA,
            pairPath[tokenA][tokenB],
            tokenB,
            pairPath[tokenB][startingToken],
            startingToken
        );
    }

    function _setTokenPairPath(address tokenA, address tokenB, bytes memory path) internal{
        pairPath[tokenA][tokenB] = path;
        pairPath[tokenB][tokenA] = path;
    }

    function _swap(bytes memory path, uint256 amountIn, uint256 amountOutMin) internal {
        swapRouter.exactInput(
            ISwapRouter.ExactInputParams({
                path: path,
                amountIn: amountIn,
                amountOutMinimum: amountOutMin,
                recipient: address(this)
            })
        );
    }

}
