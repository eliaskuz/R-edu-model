pragma solidity 0.4.21;


/**
 * @title Specs
 * @dev Library for managing addresses assigned to a Spec.
 *      See RBAC.sol for example usage.
 */
library Specs {
    struct Spec {
        mapping (address => bool) bearer;
    }

    /**
    * @dev give an address access to this role
    */
    function add(Spec storage spec, address addr) internal {
        spec.bearer[addr] = true;
    }

    /**
    * @dev remove an address' access to this role
    */
    function remove(Spec storage spec, address addr) internal {
        spec.bearer[addr] = false;
    }

    /**
    * @dev check if an address has this role
    * @return bool
    */
    function has(Spec storage spec, address addr) internal view  returns (bool) {
        return spec.bearer[addr];
    }

    /**
    * @dev check if an address has this role
    * // reverts
    */
    function check(Spec storage spec, address addr) internal view {
        require(has(spec, addr));
    }


}
