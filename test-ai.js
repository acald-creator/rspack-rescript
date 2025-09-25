#!/usr/bin/env node

/**
 * AI Features Test Script
 * Demonstrates the AI-powered color analysis capabilities
 */

const path = require("path");

// Import the AI functions (assuming they're built in the design-token-toolkit)
const toolkitPath = path.join(__dirname, "..", "design-token-toolkit", "dist");

try {
	const {
		analyzeColorIntelligence,
		generateIntelligentPalette,
		suggestBrandColorsAI,
	} = require(`${toolkitPath}/utils/color-utils`);

	async function testAIFeatures() {
		console.log("🤖 AI Color Analysis Test");
		console.log("=".repeat(40));

		const testColor = "#646cff";

		console.log(`\n🎨 Analyzing color: ${testColor}\n`);

		// Test color intelligence
		const intelligence = analyzeColorIntelligence(testColor);
		console.log("📊 Intelligence Score:", `${intelligence.score}/100`);
		console.log("🎯 Properties:", intelligence.properties);
		console.log("💡 Suggestions:", intelligence.suggestions);

		// Test palette generation
		const palette = generateIntelligentPalette(testColor, "professional");
		console.log("\n🎨 Generated Palette:");
		Object.entries(palette)
			.slice(0, 3)
			.forEach(([key, value]) => {
				console.log(`   ${key}: ${value}`);
			});

		// Test brand suggestions
		const suggestions = await suggestBrandColorsAI(testColor);
		console.log("\n🏷️  Brand Color Suggestions:");
		console.log("   Primary:", testColor);
		console.log("   Secondary:", suggestions.secondary?.color || "N/A");
		console.log("   Accent:", suggestions.accent?.color || "N/A");

		console.log("\n✅ AI Features working correctly!");
	}

	testAIFeatures().catch(console.error);
} catch (error) {
	console.error("❌ Error loading AI functions:", error.message);
	console.log(
		"💡 Make sure the design-token-toolkit is built first: cd ../design-token-toolkit && npm run build",
	);
}
