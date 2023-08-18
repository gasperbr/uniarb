// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8;

interface ISwapRouter {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }
    struct ExactInputParams {
        bytes path;
        address recipient;
        uint256 amountIn;
        uint256 amountOutMinimum;
    }
    function multicall(bytes[] memory data) external payable returns (bytes[] memory results);
    function unwrapWETH9(uint256 amountOutMinimum) external payable;
    function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut);
    function exactInput(ExactInputParams calldata params) external payable returns (uint256 amountOut);
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to
    ) external payable returns (uint256 amountOut);
    function checkOracleSlippage(bytes memory path, uint24 maximumTickDivergence, uint32 secondsAgo) external view;
}
