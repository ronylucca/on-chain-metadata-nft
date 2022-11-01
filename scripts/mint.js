// scripts/withdraw.js

const hre = require("hardhat");
const abi = require("../artifacts/contracts/ChainBattles.sol/ChainBattles.json");

async function getBalance(provider, address) {
  const balanceBigInt = await provider.getBalance(address);
  return hre.ethers.utils.formatEther(balanceBigInt);
}

async function main() {
  // Get the contract that has been deployed to Goerli.
  const contractAddress="0x598355D12a56B241D0663262f36395c5025bE3B5";
  const contractABI = abi.abi;

  // Get the node connection and wallet connection.
  const provider = new hre.ethers.providers.AlchemyProvider("mumbai", process.env.MUMBAI_API_KEY);

  // Ensure that signer is the SAME address as the original contract deployer,
  // or else this script will fail with an error.
  const signer = new hre.ethers.Wallet(process.env.PRIVATE_KEY, provider);

  // Instantiate connected contract.
  const chainBattles = new hre.ethers.Contract(contractAddress, contractABI, signer);


    const withdrawTxn = await chainBattles.mint();
    await withdrawTxn.wait();
 
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });