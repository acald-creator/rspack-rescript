# Design Token Color System

## Architecture Overview

This design system uses a **layered approach** to colors that separates concerns and enables flexibility:

### 1. Core Colors (The Palette)
Located in `tokens/color/core.json`
- Raw color values (hex codes)
- Generated from brand colors using algorithms
- Never used directly in components

### 2. Semantic Colors (The Meaning)
Located in `tokens/color/semantic.json`
- Named colors with semantic meaning
- Reference core colors using Style Dictionary references
- Used by components (primary, secondary, success, etc.)

### 3. Theme Colors (The Context)
Located in `tokens/theme/*.json`
- Context-specific color mappings
- Define how semantic colors appear in different themes
- Enable light/dark mode switching

## Color Reference System

Style Dictionary uses **references** to create relationships:

```json
{
  "color": {
    "brand": {
      "primary": {
        "value": "{color.core.primary.500.value}"
      }
    }
  }
}
```

The `{color.core.primary.500.value}` gets replaced with the actual hex value during build.

## AI-Assisted Color Generation

The `scripts/generate-colors.js` shows how AI/algorithms can help:

### Automated Palette Generation
- Generate 50-900 color scales from a single brand color
- Ensure consistent lightness steps
- Create harmonious color relationships

### Semantic Color Suggestions
- Map brand colors to semantic meanings
- Generate accessible color combinations
- Suggest color variations for states (hover, focus, etc.)

### Accessibility-First Colors
- Generate WCAG compliant color combinations
- Ensure sufficient contrast ratios
- Create color-blind friendly palettes

## Usage Examples

### In ReScript Components
```rescript
// Use semantic colors
let button = css({
  "backgroundColor": "var(--color-brand-primary)",
  ":hover": {
    "backgroundColor": "var(--color-brand-primary-hover)"
  }
})
```

### Theme Switching
```javascript
// Switch themes at runtime
import lightTheme from './themes/light.css';
import darkTheme from './themes/dark.css';

// Apply theme
document.adoptedStyleSheets = [isDark ? darkTheme : lightTheme];
```

### Brand Customization
```json
// For different brands, only change core colors
{
  "color": {
    "core": {
      "primary": {
        "500": "#ff6b6b"  // Different brand, same structure
      }
    }
  }
}
```

## Benefits

1. **Separation of Concerns**: Colors, semantics, and themes are separate
2. **Swappable Themes**: Change themes without code changes
3. **Brand Flexibility**: Easy to customize for different brands
4. **AI-Assisted**: Algorithms can generate consistent, accessible colors
5. **Type Safety**: Generated TypeScript definitions
6. **Multiple Outputs**: CSS variables, JS objects, etc.

## Building Tokens

```bash
# Build all themes
bun run tokens:build:light
bun run tokens:build:dark

# Watch for changes
bun run tokens:watch
```

This creates `src/styles/generated/themes/light.css` and `dark.css` with all the CSS variables your components can use.