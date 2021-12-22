// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "../interfaces/ERC3156FlashBorrowerInterface.sol";

interface JTokenStorage {
    function totalBorrows() external view returns (uint256);
}

interface JTokenInterface is JTokenStorage {
    function balanceOf(address owner) external view returns (uint256);
}

interface JToken is JTokenInterface {}

interface JErc20Storage {
    function underlying() external returns (address);
}

interface JErc20Interface is JErc20Storage {
    function borrow(uint256 borrowAmount) external returns (uint256);

    function repayBorrow(uint256 repayAmount) external returns (uint256);

    function liquidateBorrow(
        address borrower,
        uint256 repayAmount,
        JTokenInterface jTokenCollateral
    ) external returns (uint256);
}

interface JWrappedNativeInterface is JErc20Interface {
    function mintNative() external payable returns (uint256);
}

interface JWrappedNativeDelegator is JTokenInterface, JWrappedNativeInterface {
    function liquidateBorrowNative(
        address borrower,
        JTokenInterface jTokenCollateral
    ) external payable returns (uint256);
}

interface JCollateralCapErc20Delegator is JTokenInterface, JErc20Interface {
    function flashLoan(
        ERC3156FlashBorrowerInterface receiver,
        address initiator,
        uint256 amount,
        bytes calldata data
    ) external returns (bool);
}
