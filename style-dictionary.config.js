const StyleDictionary = require("style-dictionary");

// Custom filters for theme separation
StyleDictionary.registerFilter({
	name: "isLightTheme",
	matcher: function (token) {
		// Include all tokens, but theme-specific ones will be overridden
		return (
			token.path.includes("background") ||
			token.path.includes("text") ||
			token.path.includes("border") ||
			token.attributes.category === "color"
		);
	},
});

StyleDictionary.registerFilter({
	name: "isDarkTheme",
	matcher: function (token) {
		return (
			token.path.includes("background") ||
			token.path.includes("text") ||
			token.path.includes("border") ||
			token.attributes.category === "color"
		);
	},
});

// Custom transform for theme-aware token building
StyleDictionary.registerTransform({
	name: "themeSelector",
	type: "attribute",
	transformer: function (token) {
		// This would be enhanced to select theme-specific values
		return token;
	},
});

module.exports = {
	source: [
		"tokens/color/core.json",
		"tokens/color/semantic.json",
		"tokens/size/base.json",
		"tokens/typography/base.json",
		"tokens/theme/light.json", // Include light theme
	],
	platforms: {
		cssThemes: {
			transformGroup: "css",
			buildPath: "src/styles/generated/themes/",
			files: [
				{
					destination: "light.css",
					format: "css/variables",
					filter: "isLightTheme",
					options: {
						outputReferences: true,
					},
				},
			],
		},
	},
};
