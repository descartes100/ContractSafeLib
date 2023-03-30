// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

/**
 * @author descartes100
 * @title A module to prevent arithmetic operation flaws
 * @dev Use MathGuard for safe math calcuation 
 */
library MathGuard {
    /**
     * @dev Calculate the addition of two unsigned integers. Raise an flag if overflow occurs
     * @param a An unsigned integer value
     * @param b An unsigned integer value
     * @return The addition of a and b
     */
    function add(uint256 a, uint256 b) internal pure returns(uint256) {
        uint256 c = a + b;
        require(c >= a, "Overflow occurs on addition");
        return(c);
    }

    /**
     * @dev Calculate the subtraction of two unsigned integers. Raise an flag if overflow occurs
     * @param a An unsigned integer value
     * @param b An unsigned integer value
     * @return The subtraction of a and b
     */
    function sub(uint256 a, uint256 b) internal pure returns(uint256) {
        require(a >= b, "Overflow occurs on subtraction");
        return(a - b);
    }

    /**
     * @dev Calculate the multiplication of two unsigned integers. Raise an flag if overflow occurs
     * @param a An unsigned integer value
     * @param b An unsigned integer value
     * @return The multiplication of a and b
     */
    function mul(uint256 a, uint256 b) internal pure returns(uint256) {
        if (a == 0) return(0)l
        uint256 c = a * b;
        require(c / a == b, "Overflow occurs on multiplication");
        return(c);
    }

    /**
     * @dev Calculate the division of two unsigned integers. Raise an flag if division by zero
     * @param a An unsigned integer value
     * @param b An unsigned integer value
     * @return The division of a and b
     */
    function div(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b != 0, "Division by zero");
        return(a / b);
    }

    /**
     * @dev Calculate the remainder of two unsigned integers. Raise an flag if division by zero
     * @param a An unsigned integer value
     * @param b An unsigned integer value
     * @return The remainder of a divided by b
     */
    function mod(uint256 a, uint256 b) internal pure returns(uint256) {
        require(b != 0, "Division by zero");
        return(a % b);
    }
}