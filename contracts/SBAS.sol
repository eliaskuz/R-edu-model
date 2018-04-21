pragma solidity 0.4.21;

import "./Specs.sol";


/**
 * @title SBAS (Spec-Based Access System)
 * @author Matt Condon (@Shrugs)
 * @dev Stores and provides setters and getters for roles and addresses.
 * @dev Supports unlimited numbers of roles and addresses.
 * @dev See //contracts/mocks/RBACMock.sol for an example of usage.
 * This RBAC method uses strings to key roles. It may be beneficial
 *  for you to write your own implementation of this interface using Enums or similar.
 * It's also recommended that you define constants in the contract, like ROLE_ADMIN below,
 *  to avoid typos.
 */
contract SBAS {
    using Specs for Specs.Spec;

    mapping (string => Specs.Spec) private specs;

    event SpecAdded(address addr, string specName);
    event SpecRemoved(address addr, string specName);

  /**
    * @dev reverts if addr does not have role
   * @param addr address
   * @param roleName the name of the role
   * // reverts
   */
    function checkSpec(address addr, string specName) public view {
        specs[specName].check(addr);
    }

  /**
   * @dev determine if addr has role
   * @param addr address
   * @param roleName the name of the role
   * @return bool
   */
    function hasSpec(address addr, string specName) public view returns (bool) {
        return specs[specName].has(addr);
    }

  /**
   * @dev add a role to an address
   * @param addr address
   * @param roleName the name of the role
   */
    function addSpec(address addr, string specName) internal {
        specs[specName].add(addr);
        emit SpecAdded(addr, specName);
    }

  /**
   * @dev remove a role from an address
   * @param addr address
   * @param roleName the name of the role
   */
    function removeSpec(address addr, string specName) internal {
        specs[specName].remove(addr);
        emit SpecRemoved(addr, specName);
    }

  /**
   * @dev modifier to scope access to a single role (uses msg.sender as addr)
   * @param roleName the name of the role
   * // reverts
   */
    modifier onlySpec(string specName) {
        checkSpec(msg.sender, specName);
        _;
    }
}
