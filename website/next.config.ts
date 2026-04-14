import type { NextConfig } from "next";

const isGHPages = process.env.GITHUB_ACTIONS === "true";

const nextConfig: NextConfig = {
  output: "export",
  basePath: isGHPages ? "/vidyalaxmi" : "",
  assetPrefix: isGHPages ? "/vidyalaxmi/" : "",
  images: {
    unoptimized: true,
  },
};

export default nextConfig;
