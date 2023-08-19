pragma solidity ^0.8.19;
import { Math, Casting } from "prb-math/UD60x18.sol";

 contract Toolkit {
    uint256 constant Q96 = 0x1000000000000000000000000;

   /**
     * @param token0Token1 the price of token0/token1 in token1 decimals
     * @param token0Decimals the decimals of token0
     * @return sqrtPriceX96 sqrt price of token0/token1
     */
    function encodePriceSqrt(uint256 token0Token1, uint8 token0Decimals)
        pure
        public
        returns (uint160 sqrtPriceX96)
    {
        uint256 oneDecimals = 10 ** token0Decimals;
        // ValueType.UD60x18 reserves = Casting.ud60x18(token0Token1 / uint256(oneDecimals));
        uint256 sqrtReserves = Math.sqrt(Casting.ud60x18(token0Token1 / uint256(oneDecimals)));
        uint256 sqrtPrice96 = sqrtReserves * Q96;
        return uint160(sqrtPrice96);
    }
 }
