pragma solidity ^0.4.18;

contract Optimist {

    uint256 public stake;

    struct Data {
        bytes input;
        address sender;
    }

    constructor(uint _stake) {
        stake = _stake;
    }

    function commit(bytes input) external {

    }

    function challenge() external {

    }

}
