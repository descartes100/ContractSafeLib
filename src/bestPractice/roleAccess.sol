// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

/**
 * @author descartes100
 * @title A module enabling role based access
 * @dev Inheriting the RoleAccess contract to endow account the role access to specific functions
 */
abstract contract RoleAccess {
    bytes16 private constant _HEXSYMBOLS = "0123456789abcdef";
    struct RoleMember {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    mapping(bytes32 => RoleMember) private _roles;
    event RoleEndowed(bytes role, address roleAddr, address roleAdmin);
    event RoleGivedUp(bytes role, address roleAddr);
    event RoleStoped(bytes role, address roleAddr);
    event AdminRoleChanged(bytes role, bytes preAdmin, bytes newAdmin);

    /**
     * @dev Use onlyRole modifier to make functions only accessible to specified role
     * @param role The bytes representation of the specified role
     */
    modifier onlyRole(bytes role) virtual{
        require(_roles[role].members[msg.sender], 
        abi.encodePacked("Only", toHexString(32, uint256(role)), "has access"));
    }

    /**
     * @dev Converts a `uint256` value to its ASCII `string` hexadecimal value with specified length.
     * @param len The specified length of new hexadecimal value
     * @param val The original `uint256` value
     */
    function toHexString(uint256 len, uint256 val) internal pure returns (string memory) {
        bytes memory stringbuf = new bytes(2 + 2 * len);
        stringbuf[0] = "0";
        stringbuf[1] = "x";
        for (uint256 i = 1 + 2 * len; i > 1; --i) {
            stringbuf[i] = _HEXSYMBOLS[val & 0xf];
            val >>= 4;
        }
        require(val == 0, "hex length insufficient");
        return string(stringbuf);
    }

    /**
     * @dev Admin endow role to specified account
     * @param role The bytes representation of the specified role
     * @param account The address of the endowed role
     */
    function endowRole(bytes32 role, address account) public virtual onlyRole(getRoleAdmin(role)) {
        if (!_roles[role].members[account]) {
            _roles[role].members[account] = true;
            emit RoleEndowed(role, account, msg.sender);
        }
    }

    /**
     * @dev Get the admin address of specified role
     * @param role The bytes representation of the specified role
     * @return The admin role of specified role
     */
    function getAdminRole(bytes32 role) public view virtual returns(bytes32) {
        return _roles[role].adminRole;
    }

    /**
     * @dev The role account itself give up the role. Can only be called by the role account itself.
     * @param role The bytes representation of the specified role
     * @param account The address of the role account
     */
    function giveUpRole(bytes32 role, address account) public virtual {
        require(account == msg.sender, "Only the role itself can give up the role");
        if (_roles[role].members[account]) {
            _roles[role].members[account] = false;
            emit RoleGivedUp(role, account);
        }
    }

    /**
     * @dev The adminRole account stop the specified role access. Can only be called by the adminRole.
     * @param role The bytes representation of the specified role
     * @param account The address of the role account
     */
    function stopRole(bytes32 role, address account) public virtual onlyRole(getRoleAdmin(role)) {
        if (_roles[role].members[account]) {
            _roles[role].members[account] = false;
            emit RoleStoped(role, account);
        }
    }

    /**
     * @dev Set the admin role of specified role. Internal function without access restriction.
     * @param adminRole The bytes representation of the admin role
     * @param role The bytes representation of the role
     */
    function setAdminRole(bytes32 adminRole, bytes32 role) internal virtual {
        bytes preAdminRole = getAdminRole(role);
        _roles[role].adminRole = adminRole;
        emit AdminRoleChanged(role, preAdminRole, adminRole);
    }
}