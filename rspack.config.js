const BundleAnalyzerPlugin =
  require("webpack-bundle-analyzer").BundleAnalyzerPlugin;
const ReactRefreshPlugin = require('@rspack/plugin-react-refresh');
const isDev = process.env.NODE_ENV === "development";

/**
 * @type {import('@rspack/cli').Configuration}
 */
module.exports = {
  plugins: [
    // new BundleAnalyzerPlugin(),
    new ReactRefreshPlugin(),
  ],
  experiments: {
    rspackFuture: {
      disableTransformByDefault: true,
    },
  },
  mode: isDev ? "development" : "production",
  context: __dirname,
  entry: {
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
      {
        test: /\.[jt]sx?$/,
        use: {
          loader: "builtin:swc-loader",
          options: {
            jsc: {
              parser: {
                syntax: "typescript",
                jsx: true,
              },
              transform: {
                react: {
                  development: isDev,
                  refresh: isDev,
                },
              },
            },
          },
        },
      },
    ],
  },
};
