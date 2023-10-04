const BundleAnalyzerPlugin =
  require("webpack-bundle-analyzer").BundleAnalyzerPlugin;
/**
 * @type {import('@rspack/cli').Configuration}
 */
module.exports = {
  // plugins: [new BundleAnalyzerPlugin()],
  context: __dirname,
  entry: {
    // main: "./src/main.tsx",
    main: "./src/main.bs.js",
  },
  builtins: {
    html: [
      {
        template: "./index.html",
      },
    ],
  },
  module: {
    rules: [
      {
        test: /\.svg$/i,
        issuer: /\.[jt]sx?$/,
        use: ["@svgr/webpack"],
      },
    ],
  },
};
