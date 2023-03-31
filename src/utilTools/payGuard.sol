// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

/**
 * @author descartes100
 * @title A module to implement safe payment 
 * @dev Inherit PayGuard to let payer withdraw their payments themselves to avoid direct contract calling 
 */
abstract contract PayGuard{
    mapping(address => uint256) private _payments;
    event Paid(address indexed payee, uint256 payAmount);
    event Withdrawn(address indexed payee, uint256 payAmount);

    /**
     * @dev Return the payment amount of specified payee 
     * @param payee The address of payee
     */
    function paymentOf(address payee) public view returns (uint256) {
        return _payments[payee];
    }

    /**
     * @dev Payee makes payments with embedded msg.value call
     * @param payee The address of payee
     */
    function pay(address payee) public payable virtual {
        uint256 amount = msg.value;
        _payments[payee] += amount;
        emit Paid(payee, amount);
    }

    /**
     * @dev A virtual function can be modified to set withdrawn condition
     * @param payee The address of the payee
     * @return Return true if the payee meets the withdrawn condition
     */
    function withdrawAllowed(address payee) public view virtual returns (bool) {}

    /**
     * @dev Payee withdraw payments, a virtual function can be modified 
     * @param payee The address of the payee
     */
    function withdrawPayment(address payable payee) public virtual {
        require(withdrawAllowed(payee), "Payee is not allowed to withdraw");
        uint256 payment = _payments[payee];
        _payments[payee] = 0;
        sendValue(payee, payment);
        emit Withdrawn(payee, payment);
    }

    /**
     * @dev An internal function to make safe value transfering
     * @param recipient The address of the recipient
     * @param amount The amount of withdrawn payment
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Insufficient balance");
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Unable to send value");
    }
}