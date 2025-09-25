// AI-Assisted Color Generation for Design Tokens
// This shows how AI/algorithms can help generate color variations

// Example: Generate a full color palette from a single brand color
function generateColorPalette(baseColor) {
	// This would use color theory algorithms to generate:
	// - Lighter/darker variants
	// - Complementary colors
	// - Triadic color schemes
	// - Accessible color combinations

	return {
		50: lighten(baseColor, 0.9),
		100: lighten(baseColor, 0.8),
		200: lighten(baseColor, 0.6),
		300: lighten(baseColor, 0.4),
		400: lighten(baseColor, 0.2),
		500: baseColor,
		600: darken(baseColor, 0.2),
		700: darken(baseColor, 0.4),
		800: darken(baseColor, 0.6),
		900: darken(baseColor, 0.8),
	};
}

// Example: Generate semantic colors based on brand colors
function generateSemanticColors(brandColors) {
	return {
		success: "#10b981", // Fixed green for success
		warning: "#f59e0b", // Fixed amber for warning
		error: "#ef4444", // Fixed red for error
		info: brandColors.primary, // Use brand primary for info
	};
}

// Example: Generate accessible color combinations
function generateAccessibleColors(baseColor) {
	// Use WCAG contrast algorithms to ensure readable combinations
	return {
		onLight: getAccessibleTextColor(baseColor, "#ffffff"),
		onDark: getAccessibleTextColor(baseColor, "#000000"),
	};
}

// Example usage in a token generation script
const brandInput = {
	primary: "#646cff",
	secondary: "#535bf2",
};

// Generate full token set
const tokens = {
	color: {
		core: {
			primary: generateColorPalette(brandInput.primary),
			secondary: generateColorPalette(brandInput.secondary),
		},
		semantic: generateSemanticColors(brandInput),
	},
};

module.exports = tokens;
