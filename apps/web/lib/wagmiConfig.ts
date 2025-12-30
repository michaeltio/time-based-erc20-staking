"use client";
import { createConfig, http } from "wagmi";
import { mainnet, sepolia } from "wagmi/chains";

export const config = createConfig({
  chains: [mainnet, sepolia],
  transports: {
    [mainnet.id]: http(),
    [sepolia.id]: http(
      "https://sepolia.infura.io/v3/cacfe30346a54a1993934247d94a3cce"
    ),
  },
});
