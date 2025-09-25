# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Development
- `bun run dev` - Start development server with hot reload (ReScript watch + Rspack dev server on http://localhost:8080)
- `bun run build` - Create production build in dist/
- `bun run res:dev` - Run ReScript compiler in watch mode only
- `bun run preview` - Preview production build locally

### Code Quality
- `bun run lint` - Run Biome linter
- `bun run format:write` - Format code with Biome
- `bun run commit` - Create conventional commit using Commitizen

## Architecture

This is a ReScript + React SPA using Rspack (Rust-based bundler). Key architectural decisions:

### ReScript Compilation Flow
1. `.res` files are compiled to `.bs.js` ES6 modules by ReScript compiler
2. Compilation happens in-source (files appear next to .res files)
3. Rspack bundles the `.bs.js` files with React Fast Refresh support
4. `.bs.js` files are gitignored - they're build artifacts

### Module System
- ReScript modules map directly to file names (e.g., `App.res` → `App` module)
- Use `open ModuleName` to access module contents without prefixing
- Components are typically opened: `open Button` then use `<Button />`
- Bindings to JS libraries go in `src/bindings/` (e.g., `Emotion.res`)

### React Component Pattern
```rescript
@react.component
let make = (~propName: type, ~optionalProp: option<type>=?) => {
  // Component logic
  <div> {React.string("content")} </div>
}
```

### Styling with Emotion CSS-in-JS
- Styles are defined in `src/styles/Styles.res` as a module
- Use `Emotion.Css.css({...})` to create style objects
- Apply styles via className: `<div className={Styles.container}>`
- Global styles applied in main.res using `Emotion.Global.styles`

### State Management
- Currently uses React's built-in hooks (useState, useEffect, etc.)
- No Redux, MobX, or other state management libraries
- State types are inferred by ReScript's type system

## Important Development Notes

### When Creating New Components
1. Create a folder under `src/components/ComponentName/`
2. Create `ComponentName.res` file with `@react.component`
3. Props use named parameters with `~` prefix
4. Export is automatic (file name = module name)

### When Working with External JavaScript
1. Create bindings in `src/bindings/` for type safety
2. Use `@module` for ES6 imports
3. Use `external` keyword for binding to JS functions
4. Example binding pattern from Emotion.res:
```rescript
module Css = {
  external css: {..} => string = "css"
}
```

### Build System Specifics
- SVGR transforms SVGs into React components (can import .svg files)
- SWC handles JSX transformation for any TypeScript/JavaScript interop
- React Fast Refresh enabled in development for instant updates
- Source maps enabled for debugging compiled code

### File Conventions
- `.res` - ReScript source files
- `.resi` - ReScript interface files (optional, for hiding implementation)
- `.bs.js` - Generated JavaScript (DO NOT edit, gitignored)
- Components use PascalCase for files and folders
- Utilities and modules use camelCase

### Testing
No testing framework is currently configured. When adding tests, consider:
- ReScript Test or Jest with bs-jest bindings
- Tests would typically go in `__tests__` folders or `.test.res` files