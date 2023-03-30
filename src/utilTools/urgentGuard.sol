// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

/**
 * @author descartes100
 * @title A module to guard contract functions in urgency
 * @dev Inherit UrgentGuard to make your functions only callable when in urgency or not in urgency to protect your contracts
 */
abstract contract UrgentGuard {
    bool private _urgent;
    event UrgencyStarted(address caller);
    event UrgencyEnded(address caller);

    /**
     * @dev Initialize the urgent state as false
     */
    constructor() {
        _urgent = false;
    }

    /**
     * @dev Use inUrgency modifier to make the function only callable when in urgency
     */
    modifier inUrgency() {
        require(_urgent, "This function is only available when in urgency");
        _;
    }

    /**
     * @dev Use notInUrgency modifier to make the function only callable when not in urgency
     */
    modifier notInUrgency() {
        require(!_urgent, "This function is only available when not in urgency");
        _;
    }

    /**
     * @dev Start the urgency state. A virtual function can be modified. 
     * Can only be called when not in urgency. 
     */
    function startUrgency() internal virtual notInUrgency {
        _urgent = true;
        emit UrgencyStarted(msg.sender);
    }

    /**
     * @dev End the urgency state. A virtual function can be modified. 
     * Can only be called when in urgency. 
     */
    function endUrgency() internal virtual inUrgency {
        _urgent = false;
        emit UrgencyEnded(msg.sender);
    }

    /**
     * @dev Check the urgent state, public function can be called by anyone
     * @return Return true when in urgency
     */
    function checkUrgent() public view virtual returns(bool) {
        return _urgent;
    }
}