const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("Program", (m) => {
  const loyaltyToken = m.contract("LoyaltyToken");

  const program = m.contract("Program", [
    ["Request a decision from the higher ups"],
    [2],
    [10],
    loyaltyToken
  ]);

  return { loyaltyToken, program };
});
