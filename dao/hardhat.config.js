require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    amoy: {
      url: process.env.AMOY_API_URL,
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    },
    sepolia: {
      url: process.env.SEPOLIA_API_URL,
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    }
  }
};
