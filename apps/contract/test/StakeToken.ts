import assert from "node:assert/strict";
import { describe, it } from "node:test";

import { network } from "hardhat";

describe("StakeToken (viem)", async function () {
  const { viem } = await network.connect();

  it("should have correct name and symbol", async function () {
    const stakeToken = await viem.deployContract("StakeToken");

    assert.equal(await stakeToken.read.name(), "StakeToken");
    assert.equal(await stakeToken.read.symbol(), "SKT");
  });

  it("should mint total supply to owner", async function () {
    const stakeToken = await viem.deployContract("StakeToken");

    const decimals = (await stakeToken.read.decimals()) as bigint;
    const expectedSupply = 1_000_000n * 10n ** decimals;

    assert.equal(await stakeToken.read.totalSupply(), expectedSupply);

    const [owner] = await viem.getWalletClients();
    assert.equal(
      await stakeToken.read.balanceOf([owner.account.address]),
      expectedSupply
    );
  });

  it("should not mint tokens to other users", async function () {
    const stakeToken = await viem.deployContract("StakeToken");

    const [, user] = await viem.getWalletClients();

    assert.equal(await stakeToken.read.balanceOf([user.account.address]), 0n);
  });
});
