// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

/**
 * @author descartes100
 * @title A module preventing reentrancy bugs.
 * @dev Inherite from ReentrancyGuard and use the nonReentrant modifier to guard functions.
 */
abstract contract ReentrancyGuard {
    uint256 private _status;
    uint256 private constant _status_locked = 2;
    uint256 private constant _status_unlocked = 1;
    constructor() {
        _status = _status_unlocked;
    }

    /**
     * @dev Use nonReentrant modifier to avoid functions calling themselves
     */
    modifier nonReentrant() {
        require(_status != _status_locked, "Reentrant call");
        _status = _status_locked;
        _;
        _status = _status_unlocked;
    }
}