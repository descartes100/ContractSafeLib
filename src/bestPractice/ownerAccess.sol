// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

/**
 * @author descartes100
 * @title A module enabling ownership access
 * @dev Inheriting the OwnerAccess contract to endow owner the access to specific functions
 */
abstract contract OwnerAccess {
    address public ownerAddr;
    event OwnershipChanged(address indexed preOwner, address indexed newOwner);

    /**
     * @dev Start the OwnerAccess contract by specifying an owner
     * @param _ownerAddr the initialized owner address
     */
    constructor(address _ownerAddr) {
        ownerAddr = _ownerAddr;
        emit OwnershipChanged(address(0), _ownerAddr);
    }
    /**
     * @dev Use onlyOwner modifier to make function only accessible to owner. Change 
     * the behavior of onlyOwner() by inheriting it
     */
    modifier onlyOwner() virtual {
        require(msg.sender == ownerAddr, "Only owner can access");
        _;
    }

    /**
     * @dev Owner transfer ownership to the new owner
     * @param newOwnerAddr the address of the new owner
     */
    function changeOwner(address newOwnerAddr) public virtual onlyOwner {
        ownerAddr = newOwnerAddr;
        emit OwnershipChanged(msg.sender, newOwnerAddr);
    }

    /**
     * @dev Owner give up ownership and the onlyOwner functions will not work anymore
     */
    function giveUpOwnership() public virtual onlyOwner {
        ownerAddr = address(0);
        emit OwnershipChanged(msg.sender, address(0));
    }
}