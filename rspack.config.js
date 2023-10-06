const BundleAnalyzerPlugin =
	require("webpack-bundle-analyzer").BundleAnalyzerPlugin;
const rspack = require("@rspack/core");
const ReactRefreshPlugin = require("@rspack/plugin-react-refresh");
const isProduction = process.env.NODE_ENV === "production";

/**
 * @type {import('@rspack/cli').Configuration}
 */
module.exports = {
	plugins: [
		// new BundleAnalyzerPlugin(),
		new rspack.HtmlRspackPlugin({ template: "./index.html" }),
		new rspack.DefinePlugin({ "process.env.NODE_ENV": "'development'" }),
		!isProduction && new ReactRefreshPlugin(),
	].filter(Boolean),
	experiments: {
		rspackFuture: {
			disableTransformByDefault: true,
		},
	},
	mode: isProduction ? "production" : "development",
	context: __dirname,
	entry: {
		main: "./src/main.bs.js",
	},
	devtool: "source-map",
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
						sourceMap: true,
						jsc: {
							parser: {
								syntax: "typescript",
								jsx: true,
							},
							transform: {
								react: {
									runtime: "automatic",
									development: !isProduction,
									refresh: !isProduction,
								},
							},
						},
					},
				},
			},
		],
	},
};
