/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  rewrites: async () => {
    return [
      {
        source: "/builder",
        destination: "/build/web/index.html",
      },
    ];
  },
};

module.exports = nextConfig;
