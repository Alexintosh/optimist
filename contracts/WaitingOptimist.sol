pragma solidity ^0.4.24;

import "./Optimist.sol";

contract WaitingOptimist is Optimist {

    struct Commitment {
        bytes input;
        uint256 submitted;
        address submitter;
    }

    uint256 public stake;
    uint256 public cooldown;

    Commitment[] public commitments;

    event DataCommitted(address indexed committer, uint256 index);

    function submit(bytes input) external payable {
        require(msg.value == stake);

        commitments.push(
            Commitment({
                input: input,
                submitted: now,
                submitter: msg.sender
            })
        );

        emit Submitted(msg.sender, (commitments.length - 1), input);
    }

    function challenge(uint256 id) external {
        Commitment storage commitment = commitments[id];

        require(commitment.submitted + cooldown <= now);

        // @todo verify

        delete commitments[id];

        msg.sender.transfer(stake);

        emit Challenged(msg.sender, id);
    }

    function commit(uint256 id) external {
        Commitment storage commitment = commitments[id];

        require(commitment.submitted + cooldown > now);

        // @todo submit the data

        submitter = commitment.submitter;

        delete commitments[id];

        submitter.transfer(stake);

        emit Committed(msg.sender, id);
    }
}