const rspack = require("@rspack/core");
const ReactRefreshPlugin = require("@rspack/plugin-react-refresh");
const isProduction = process.env.NODE_ENV === "production";

/**
 * @type {import('@rspack/cli').Configuration}
 */
module.exports = {
	plugins: [
		new rspack.HtmlRspackPlugin({ template: "./index.html" }),
		new rspack.DefinePlugin({
			"process.env.NODE_ENV": JSON.stringify(
				isProduction ? "production" : "development",
			),
			"process.env.GRAPHQL_ENDPOINT": JSON.stringify(
				process.env.GRAPHQL_ENDPOINT || "http://localhost:4000/graphql",
			),
		}),
		!isProduction && new ReactRefreshPlugin(),
	].filter(Boolean),
	mode: isProduction ? "production" : "development",
	context: __dirname,
	entry: {
		main: "./src/main.bs.js",
	},
	devServer: {
		historyApiFallback: true,
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
				test: /\.m?js$/,
				resolve: {
					fullySpecified: false,
				},
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
