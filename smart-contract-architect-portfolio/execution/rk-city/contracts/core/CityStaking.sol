// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {CityGuards} from "../control/CityGuards.sol";

/**
 * CityStaking
 * - Stake CityToken
 * - Earn CityToken (pre-funded)
 * - rewardRate = tokens per second
 */
contract CityStaking is CityGuards {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardToken;

    uint256 public rewardRate; // tokens per second
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;

    uint256 public totalStaked;

    mapping(address => uint256) public staked;
    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    constructor(
        address admin,
        address _stakingToken,
        address _rewardToken,
        uint256 _rewardRate
    ) CityGuards(admin) {
        require(_stakingToken != address(0), "ZERO_STAKING_TOKEN");
        require(_rewardToken != address(0), "ZERO_REWARD_TOKEN");

        stakingToken = IERC20(_stakingToken);
        rewardToken  = IERC20(_rewardToken);
        rewardRate   = _rewardRate;
        lastUpdateTime = block.timestamp;
    }

    /* ========== MODIFIERS ========== */

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = block.timestamp;

        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
        _;
    }

    /* ========== VIEW FUNCTIONS ========== */

    function rewardPerToken() public view returns (uint256) {
        if (totalStaked == 0) {
            return rewardPerTokenStored;
        }

        return
            rewardPerTokenStored +
            ((block.timestamp - lastUpdateTime) * rewardRate * 1e18) /
            totalStaked;
    }

    function earned(address account) public view returns (uint256) {
        return
            ((staked[account] *
                (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18) +
            rewards[account];
    }

    /* ========== USER ACTIONS ========== */

    function stake(uint256 amount)
        external
        guarded
        nonReentrant
        updateReward(msg.sender)
    {
        require(amount > 0, "ZERO_AMOUNT");

        // Effects
        totalStaked += amount;
        staked[msg.sender] += amount;

        // Interactions
        stakingToken.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 amount)
        public
        guarded
        nonReentrant
        updateReward(msg.sender)
    {
        require(amount > 0, "ZERO_AMOUNT");

        // Effects
        totalStaked -= amount;
        staked[msg.sender] -= amount;

        // Interactions
        stakingToken.transfer(msg.sender, amount);
    }

    function claim()
        public
        guarded
        nonReentrant
        updateReward(msg.sender)
    {
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "NO_REWARD");

        // Effects
        rewards[msg.sender] = 0;

        // Interactions
        rewardToken.transfer(msg.sender, reward);
    }

    function exit() external {
        withdraw(staked[msg.sender]);
        claim();
    }

    /* ========== ADMIN ========== */

    function setRewardRate(uint256 newRate)
        external
        onlyOperator
        updateReward(address(0))
    {
        rewardRate = newRate;
    }
}
