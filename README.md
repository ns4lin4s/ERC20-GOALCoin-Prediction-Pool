# GOL-COIN & Prediction Vault ⚽🗳️

A decentralized prediction pool system built with **Solidity** and **OpenZeppelin**. This project allows communities (like WhatsApp or Telegram groups) to gamify predictions for football matches or political events using a custom ERC-20 token and a secure vault mechanism.

## 📌 Overview

This project consists of two main smart contracts:
1.  **GOALCoin (ERC-20):** A custom utility token with enhanced safety features.
2.  **PredictionVault:** A secure contract that manages the "prize pool" using the industry-standard `approve` and `transferFrom` pattern.

## 🚀 Key Features & Technical Logic

### 1. GOALCoin (ERC-20)
* **Standard Compliance:** Fully compliant with the OpenZeppelin ERC-20 implementation.
* **Transfer Restriction:** Implements a custom override of the `_transfer` function to prevent users from accidentally sending tokens to the contract address itself, avoiding permanent loss of funds.

### 2. PredictionVault (The Escrow)
* **Approve & TransferFrom Pattern:** Instead of direct transfers, the vault "pulls" tokens from the user's wallet after explicit approval. This is the standard for DeFi applications.
* **Access Control:** Utilizes OpenZeppelin's `Ownable` (v5.0+) to ensure only the designated Arbiter/Owner can distribute prizes.
* **Data Integrity:** Includes a `bytes` field in the deposit function to allow users to attach their prediction (e.g., "3-1 Local") directly to the transaction.

## 🛠️ Technologies Used

* **Solidity** (^0.8.20)
* **OpenZeppelin Contracts** (ERC20, Ownable)
* **Remix IDE** / **Hardhat**
* **Ethers.js** (for future Bot integration)

## 📖 How it Works: Step-by-Step

1.  **Setup:** The Owner deploys `GOALCoin` and then `PredictionVault` (passing the token address).
2.  **Approval:** A user wants to bet 100 GOL. They call `GOALCoin.approve(vault_address, 100)`.
3.  **Deposit:** The user calls `vault.deposit(100, "3-1")`. The Vault executes `transferFrom` and secures the tokens.
4.  **Payout:** Once the event ends, the Owner calls `vault.withdraw(winner_address, pot_amount)` to reward the winner.

## 🔧 Installation & Deployment

1.  Clone the repository:
    ```bash
    git clone [https://github.com/YOUR_USERNAME/ERC20-GOLCoin-Prediction-Pool.git](https://github.com/YOUR_USERNAME/ERC20-GOLCoin-Prediction-Pool.git)
    ```
2.  Install OpenZeppelin dependencies:
    ```bash
    npm install @openzeppelin/contracts
    ```
3.  Compile and deploy using **Remix** or **Hardhat** on any EVM-compatible Testnet (Sepolia, Polygon Amoy, etc.).


## 🏟️ Use Case: Community Prediction Pool

Imagine a WhatsApp or Telegram group of friends discussing an upcoming football match (e.g., "The Superclásico"). This project transforms a simple verbal bet into a transparent, blockchain-based game.

### The Scenario:
* **Arbiter (Owner):** The person who manages the group and the contract.
* **Participants:** Friends who want to predict the result using **GOL-COIN**.

### Step-by-Step Execution:

1.  **Preparation:** The Arbiter distributes **500 GOL** to each friend in the group.
2.  **The Challenge:** The Arbiter announces: *"Bets are open for the match! Entry fee: 100 GOL. Send your prediction in the deposit."*
3.  **The Secure Deposit (UX Flow):**
    * **Jorge** wants to bet on a 3-1 win. 
    * First, he calls `approve(vault_address, 100)` to authorize the Vault.
    * Then, he calls `deposit(100, "3-1 Local")`.
    * *Technical Note:* If Jorge tries to send the tokens directly to the Vault or the Token contract without this flow, the transaction fails, protecting his funds.
4.  **The Pot:** The **PredictionVault** now holds the "Prize Pool" (e.g., 500 GOL total from 5 friends).
5.  **Settlement:** After the match, Jorge wins. The Arbiter calls `withdraw(jorge_address, 500)`.
6.  **Transparency:** Every friend can verify on the Blockchain (via Etherscan) that the tokens were moved and paid out correctly, eliminating disputes about "who said what" in the chat.

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
*Created as a Proof of Concept for Web3 community engagement.*