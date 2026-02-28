import type { NextConfig } from "next";

const ignoredRegex =
  /[\\/]node_modules[\\/]|[\\/]\.pnpm-store[\\/]|[\\/]\.git[\\/]|[\\/]\.next[\\/]|[\\/]\.turbo[\\/]/;

const nextConfig: NextConfig = {
  turbopack: {},
  webpack: (config, { dev }) => {
    if (dev) {
      config.watchOptions = {
        ...config.watchOptions,
        followSymlinks: false,
        ignored: ignoredRegex,
      };
    }
    return config;
  },
};

export default nextConfig;
