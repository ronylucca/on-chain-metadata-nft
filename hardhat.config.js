// hardhat.config.js

require("dotenv").config()
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const PRIVATE_KEY = process.env.PRIVATE_KEY;
const MUMBAI_URL = process.env.MUMBAI_URL

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    mumbai: {
      url: MUMBAI_URL,
      accounts: [PRIVATE_KEY]
    }
  },
  etherscan:{
    apiKey: process.env.POLYGON_SCAN_API_KEY
  }
};