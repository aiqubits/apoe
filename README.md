## Basic Info
Project Name: APOE

## Project Details

### Introduction
APOE is a decentralized supply chain verification solution.

### Insights
To build a supply chain verification solution, we need to design a system that ensures the authenticity and compliance of goods throughout the supply chain. This involves creating a secure and transparent record of transactions and ownership transfers.

### System Design
1. Smart Contracts:
Develop smart contracts to manage the lifecycle of goods, including creation, transfer, and verification. These contracts will be executed on the Aleo blockchain.

2. Data Storage:
Integrate decentralized storage solutions like IPFS for storing large files (e.g., product images, documents) that are referenced in the blockchain records.

3. Identity Management:
Implement a secure identity management system using private keys and addresses to authenticate participants in the supply chain.

4. API Layer:
Create an API layer to facilitate communication between the front-end application and the blockchain. This layer will handle data validation and transaction submission.

5. Front-End Application:
Develop a user-friendly front-end application that allows companies to interact with the system, view their supply chain status, and verify goods.

### Example User Flow

1. Registration and Identity Setup:
A company registers in the system by providing necessary details and receives a private key and address.

```bash
# Example of setting up .env file with private key
echo "NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkpHtqVWT6fSHgUMNxsuVf7eaR6id2cj7TieKY1Z8CP5rCD" > .env
```

2. Product Creation:
The company creates a new product entry by submitting details through the front-end application. This triggers a smart contract to create a new record on the blockchain.

```bash
# Example of running a transition function to create a product
leo run create_product 100u64
```

3. Transfer of Ownership:
When the product is transferred to another party in the supply chain, the current owner submits a transfer request. The smart contract updates the ownership record.

```bash
# Example of running a transition function to transfer ownership
leo run transfer_ownership Hash_of_Product aleo1t0uer3jgtsgmx5tq6x6f9ecu8tr57rzzfnc2dgmcqldceal0ls9qf6st7a
```

4. Verification Request:
A buyer or regulator requests verification of a product by querying the blockchain through the front-end application. The system retrieves the product's history and verifies its authenticity.

```bash
# Example of querying the blockchain for product verification
leo run verify_product Hash_of_Product
```

5. View Supply Chain Status:
Users can view the current status of their supply chain, including all transactions and ownership history, directly through the front-end application.

```bash
# Example of querying the blockchain for supply chain status
leo run view_product_status Hash_of_Product
```
