<img src="./assets/readMeImage.png" width="100%"/>
<h1>`ERC-20` Token interface implementation</h1>
<h2>What this contract does?</h2>

This contract is a high-level implementation of the `ERC-20` protocol.
This contract writes the main functionalities of the protocol to transfer, give allowance to other addresses, mint tokens and give the token a symbol and name.
Go through this code to understand better how the `ERC-20` protocol works and its main features and functions.

<h3>What is ERC-20?</h3>

The `ERC-20` protocol is a technical standard used for creating and managing tokens on the Ethereum blockchain. Essentially, it defines a common set of rules that all Ethereum tokens must follow, enabling different types of tokens to interact with each other, with smart contracts, and with decentralized applications (dApps) in a uniform manner.

<h3>Why was created ERC-20?</h3>

Before the introduction of `ERC-20`, there was no standard for tokens on the Ethereum blockchain. This led to compatibility issues between different tokens and made it challenging to create smart contracts that could interact with multiple tokens. The `ERC-20` standard was created to standardize how tokens are issued, transferred, and managed on Ethereum, making it easier to develop decentralized applications and ensure interoperability between tokens.

<h3>When and Who Created the ERC-20 Protocol?</h3>

The `ERC-20` protocol was proposed by Fabian Vogelsteller and Vitalik Buterin in November 2015. Vogelsteller is a developer who has worked extensively in the Ethereum ecosystem, and Vitalik Buterin is the creator of Ethereum. Together, they proposed this standard as a solution to the growing need for uniformity in the creation and management of tokens.

<h3>What is an ERC-20 Token?</h3>

An `ERC-20` token is a token that follows the rules defined by the `ERC-20` standard. These tokens are essentially smart contracts that operate on the Ethereum blockchain and represent fungible assets, meaning each token has the same value and is interchangeable with any other token of the same type.

<h3>What Does the ERC-20 Protocol Do?</h3>

The `ERC-20` protocol defines six mandatory and three optional functions that must be implemented in a token contract. These functions include:

- **Total Supply**: Defines the total number of tokens that will exist.
- **Balance Of**: Provides the balance of tokens for a specific address.
- **Transfer**: Allows tokens to be transferred from one address to another.
- **Approve**: Allows an address to approve another address to withdraw tokens.
- **Transfer From**: Allows tokens to be transferred on behalf of another address, provided they have been approved.
- **Allowance**: Returns the remaining number of tokens that an approved spender is allowed to withdraw.
