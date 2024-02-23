import { ethers } from "hardhat";

async function main() {

  const PollFactory = await ethers.getContractFactory("PollFactory");

  const pollFactory = await PollFactory.deploy();

  await pollFactory.deployed();

  console.log("PollFactory deployed to:", pollFactory.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
