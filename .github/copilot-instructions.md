# Copilot Instructions for rspack-rescript

## Architecture Overview
This is a ReScript + React application bundled with Rspack, using Emotion for CSS-in-JS styling. ReScript compiles `.res` files to `.bs.js` ES6 modules in-source, which Rspack then bundles for the web. The app is a simple single-page React app with no routing, API calls, or complex state management.

- **Entry Point**: `src/main.res` renders `<App />` into `#root` (see `index.html`).
- **Components**: Located in `src/components/`, each in its own folder (e.g., `Button/Button.res`). Components use `@react.component` and follow the pattern: `module Component = { @react.component let make = (~props) => <element> ... </element> }`. Examples: Button with ~onClick and ~children, Input with no props, Label with ~children.
- **Styling**: CSS-in-JS via Emotion. Styles defined in `src/styles/Styles.res` using `Emotion.Css.css({})` (e.g., `let button = css({"padding": "1rem"})`). Applied as `className={Styles.className}`. Global styles injected in `main.res` and `App.res` with `Emotion.Css.injectGlobal(\`...\`)` for root styles, logo animations, and media queries.
- **Bindings**: External JS libraries bound in `src/bindings/` (e.g., `Emotion.res` for `@emotion/css` with externals like `css`, `injectGlobal`).
- **Build Flow**: `rescript` compiles `.res` to `.bs.js` in-source (ES6 modules), then `rspack` bundles the JS. Why in-source: Simplifies build by compiling directly alongside source files.
- **Assets**: SVGs in `src/assets/` (e.g., `react.svg`) imported as React components via SVGR in rspack.config.js.
- **TypeScript Interop**: `tsconfig.json` configured for JSX (react-jsx), `src/react-env.d.ts` declares CSS module types. Primarily ReScript-focused, but allows .tsx if needed.

## Recommended Architecture (Using What's in Place)
The current setup leverages ReScript for type-safe, functional React development, Rspack for fast bundling (compatible with Webpack configs but optimized for speed), Bun for rapid package management and script execution, Emotion for scoped CSS-in-JS, and Biome for efficient linting/formatting. This non-traditional stack provides excellent performance and developer experience for a simple app, with hot-reload on both compilation and bundling via concurrently running `res:dev` and `rspack serve`.

Key strengths:
- **Type Safety**: ReScript catches errors at compile-time, reducing runtime bugs.
- **Performance**: Rspack's speed (based on Rust) and Bun's fast installs/scripts make builds/dev fast.
- **Simplicity**: In-source compilation avoids complex build pipelines; Emotion keeps styles co-located.
- **Quality**: Pre-commit hooks ensure consistent code via Biome and commitlint.

For growth: Add testing (e.g., Jest + @testing-library/react), routing (e.g., rescript-react-router), or state management (e.g., Zustand) as needed, but keep the core stack for its efficiency.

## Alternative Architecture (Vite-Based)
Switch to Vite for bundling instead of Rspack, using `vite-plugin-rescript` to integrate ReScript compilation. This makes sense because Vite provides a more unified dev experience—no need for `concurrently` to run separate watchers—and its native ES modules handling aligns well with ReScript's output, simplifying the build chain for a simple app. Vite's dev server is optimized for React with instant HMR, and production builds are fast via esbuild/Rollup.

Migration steps:
1. Install `vite`, `@vitejs/plugin-react`, `vite-plugin-rescript`.
2. Replace `rspack.config.js` with `vite.config.js` (entry: `src/main.res`, plugins: rescript and react).
3. Update scripts: `dev: "vite"`, `build: "vite build"`, remove `res:dev` concurrency.
4. Keep Bun for package management.

Why this alternative: It reduces tooling complexity while maintaining speed, as Vite handles both compilation and bundling in one process, making it more intuitive for React/ReScript projects.

## Recommended Tech Stacks Using Rspack Directly
Rspack is a fast Rust-based bundler compatible with Webpack APIs, offering features like code splitting, tree shaking, HMR, and SWC integration. For direct use (without Rsbuild), configure via `rspack.config.js`. Recommended stacks based on project needs:

- **React + TypeScript + Rspack**: For type-safe React apps. Use SWC loader for fast TS/JSX transpilation, React Refresh for HMR. Ideal for modern web apps needing Webpack-like flexibility. (E.g., replace ReScript with TS for broader ecosystem.)
- **Vue + TypeScript + Rspack**: Framework-agnostic setup with Vue loader. Fast builds for Vue projects, with module federation for micro-frontends.
- **Svelte + Rspack**: Use Svelte loader for component compilation. Lightweight for performance-critical apps.
- **Library Development**: Use Rslib (Rspack-based) for building reusable libraries with dual formats (ESM/CJS). Supports React/Vue components.
- **Documentation Sites**: Use Rspress (Rspack-based) for static docs with MDX support.
- **Testing**: Use Rstest for Rspack ecosystem testing, with Jest-like API.
- **Analysis**: Use Rsdoctor for build insights and optimization.

For this ReScript project, raw Rspack config is necessary since Rsbuild/Rspress don't support ReScript yet. Use SWC for JS processing, HtmlRspackPlugin for HTML, and SVGR for assets.

## Recommended Tech Stack for Using ReScript
ReScript is a robustly typed language that compiles to efficient, human-readable JavaScript, with a fast compiler toolchain that scales to any codebase size. It emphasizes type safety, functional programming, and seamless JavaScript interop. Recommended stack:

- **ReScript + React + Bundler (Rspack/Vite)**: For building type-safe React apps. Use `@rescript/react` for bindings, compile to JS, then bundle with Rspack (as in this project) or Vite for dev/prod.
- **ReScript + Node.js**: For backend/server-side code, leveraging type safety for APIs or tooling.
- **ReScript + Web APIs**: For web apps without frameworks, using direct DOM manipulation or libraries.
- **Gradual Adoption**: Integrate ReScript into existing JS/TS projects by compiling modules and importing them.

Why ReScript: Superior type inference, no null/undefined issues, functional style, fast compilation, easy JS interop. Generates clean JS without runtime overhead.

## Design System Approaches
Designing a design system is challenging, with no one-size-fits-all solution. Below is a thorough research on various methods, including CSS-in-JS (currently used), pros/cons, and recommendations for different scenarios.

### 1. CSS-in-JS (Current Approach with Emotion)
- **Description**: Styles defined in JavaScript/TypeScript using libraries like Emotion, Styled Components.
- **Pros**: Scoped styles, dynamic theming, co-located with components, TypeScript integration.
- **Cons**: Runtime overhead, larger bundle size, learning curve.
- **Best For**: Component-heavy apps, dynamic themes, teams comfortable with JS.
- **Example**: `Emotion.Css.css({"color": "red"})` applied as `className`.

### 2. CSS Modules
- **Description**: CSS files scoped to components, imported as objects.
- **Pros**: Zero runtime, static analysis, familiar CSS syntax.
- **Cons**: Requires build tools, no dynamic styles, file management.
- **Best For**: Static designs, teams preferring CSS, performance-critical apps.
- **Example**: `styles.module.css` with `import styles from './styles.module.css'`.

### 3. Utility-First CSS (e.g., Tailwind CSS)
- **Description**: Pre-defined utility classes for rapid styling.
- **Pros**: Fast prototyping, consistent design, small bundle with purging.
- **Cons**: Verbose markup, learning class names, less customizability.
- **Best For**: Rapid development, design systems with fixed scales, teams wanting speed over custom styles.
- **Example**: `<div class="bg-red-500 text-white p-4">`.

### 4. Traditional CSS with Methodologies (BEM, SMACSS, OOCSS)
- **Description**: Global CSS with naming conventions for modularity.
- **Pros**: No build tools needed, full CSS power, predictable.
- **Cons**: Global scope issues, maintenance at scale, no scoping.
- **Best For**: Legacy projects, simple apps, teams with strong CSS skills.
- **Example**: `.block__element--modifier { color: red; }`.

### 5. Atomic CSS
- **Description**: Single-purpose classes for each style property.
- **Pros**: Minimal CSS, predictable, reusable.
- **Cons**: Verbose HTML, hard to read, limited for complex styles.
- **Best For**: Performance-obsessed apps, static sites.
- **Example**: `<div class="c-red fw-bold p-4">`.

### 6. Styled Components
- **Description**: Component-based styling with tagged template literals.
- **Pros**: Scoped, themeable, familiar CSS syntax.
- **Cons**: Runtime cost, larger bundles, React-specific.
- **Best For**: React apps, design systems with variants.
- **Example**: `const Button = styled.button`color: red;``.

### 7. Design Tokens + Theme Objects
- **Description**: Centralized tokens (colors, spacing) used across methods.
- **Pros**: Consistency, easy theming, method-agnostic.
- **Cons**: Requires tooling, not a styling method itself.
- **Best For**: Any approach, scalable design systems.
- **Example**: `theme.colors.primary` used in CSS-in-JS or CSS custom properties.

### 8. CSS Custom Properties (CSS Variables)
- **Description**: Dynamic CSS with variables for theming.
- **Pros**: Native, performant, runtime theming.
- **Cons**: No scoping, limited logic, browser support.
- **Best For**: Theming, simple dynamic styles.
- **Example**: `:root { --color-primary: red; } .btn { color: var(--color-primary); }`.

### 9. Component Libraries (e.g., Material-UI, Ant Design)
- **Description**: Pre-built components with integrated styles.
- **Pros**: Fast setup, consistent, accessible.
- **Cons**: Less customization, bundle bloat, vendor lock-in.
- **Best For**: MVPs, teams without designers, standard UIs.
- **Example**: `<Button variant="contained">`.

### 10. Hybrid Approaches
- **Description**: Combine methods (e.g., Tailwind + CSS-in-JS).
- **Pros**: Flexibility, best of both worlds.
- **Cons**: Complexity, tooling overhead.
- **Best For**: Complex apps needing multiple paradigms.

### Recommendations
- **For This Project**: Stick with CSS-in-JS (Emotion) for component co-location and TypeScript integration. Consider adding design tokens for consistency.
- **For Performance**: CSS Modules or Tailwind for static, optimized bundles.
- **For Simplicity**: Traditional CSS for small projects.
- **For Scalability**: Utility-first or component libraries for rapid growth.
- **General Advice**: Start with tokens, choose based on team skills and app needs. Test bundle size and performance.

This research covers major methods; the best choice depends on project requirements, team expertise, and performance goals.

## Getting Started with ReScript for TypeScript Developers
If you're experienced with TypeScript, ReScript offers a compelling alternative with stronger type guarantees and functional programming. Key differences and tips:

- **Type System**: ReScript has superior type inference (often no annotations needed), no `null`/`undefined` (uses `option` types), and immutable data by default. Think of it as "TypeScript on steroids" with functional roots.
- **Syntax**: Similar to TS/JS but functional. Props use `~` (e.g., `~onClick`), modules are explicit, JSX is automatic (no imports).
- **Interop**: Bind TS/JS libraries easily with `@module` externals. ReScript generates clean JS that integrates seamlessly.
- **Learning Path**: Start with the [ReScript Playground](https://rescript-lang.org/try) for syntax. Read the [Language Manual](https://rescript-lang.org/docs/manual/latest/introduction) and [React Guide](https://rescript-lang.org/docs/react/latest/introduction). For gradual adoption, add ReScript files to existing TS projects (compile to JS, import in TS).
- **Migration Tips**: Replace TS interfaces with ReScript records/types. Use `option` for nullable values. Leverage pattern matching over conditionals.
- **Tools**: Use VSCode with ReScript extension for intellisense. Biome for formatting (similar to Prettier). No need for complex TS configs.
- **Creating Bindings**: ReScript excels at binding JS libraries. Use `@module` for imports, `@val` for globals, and externals for functions/objects. Example: `external css: {..} => string = "css"` (see `src/bindings/Emotion.res`). Research areas: Popular libs like Lodash, Axios, or custom TS codebases. Check [ReScript Packages](https://rescript-lang.org/packages) for existing bindings; create new ones for untyped JS or to improve TS interop.

Why add ReScript: It catches more errors at compile-time, scales better for large apps, and produces efficient JS without runtime overhead.

## Developer Workflows
- **Install**: `bun install` (uses Bun package manager for speed).
- **Dev Server**: `bun run dev` runs `concurrently "bun run res:dev" "rspack serve"` for hot-reload on both ReScript compilation and bundling. React Refresh enabled for fast component updates.
- **Build Production**: `bun run build` (sets `NODE_ENV=production`, runs `rspack build` with minification).
- **ReScript Only**: `bun run res:build` (one-time compile), `bun run res:dev` (watch mode with incremental builds), `bun run res:clean` (clean build artifacts like .bs.js, lib/).
- **Formatting/Linting**: `bun run format:write` (Biome format), `bun run lint` (Biome lint). Ignores `*.bs.js`, `dist`, `lib` in biome.json.
- **Commits**: Use `bun run commit` (Commitizen interactive prompt for conventional commits). Husky enforces: pre-commit runs format and lint; commit-msg runs commitlint with @commitlint/config-conventional.
- **Debugging**: Use `bun run dev` for source-mapped dev server. Source maps enabled in rspack.config.js. No dedicated debugging tools beyond browser dev tools.
- **Testing**: None currently set up (no test scripts in package.json).
- **Deployment**: Via Vercel.sh (mentioned in README; no vercel.json seen, likely auto-configured).
- **Bundle Analysis**: Uncomment `BundleAnalyzerPlugin` in rspack.config.js to visualize bundle size.

## Conventions and Patterns
- **File Structure**: `.res` files in `src/`, compiled `.bs.js` alongside (ignored in .gitignore). Components in subfolders under `src/components/`. Bindings in `src/bindings/`, styles in `src/styles/`, assets in `src/assets/`.
- **Imports**: Use `open Module` at file top for unqualified access (e.g., `open Styles` in components to use `Styles.button`).
- **JSX**: Automatic JSX v4 (configured in bsconfig.json), no imports needed. Matches React 17+ JSX transform.
- **Props**: Named parameters with `~` (e.g., `~onClick`, `~children`). No positional arguments. Children are explicit.
- **State**: `React.useState(() => initial)` for hooks (e.g., counter in App.res). No external state management.
- **External Components**: Bind SVGs or JS components with `@module("./path") @react.component external make: (~props) => React.element = "default"` (e.g., Logo in App.res).
- **Emotion Usage**: `open Emotion.Css` for `css`, `injectGlobal`. Styles as objects (e.g., `{"padding": "1rem"}`).
- **Ignored Files**: .gitignore excludes `*.bs.js`, `/lib/`, `dist`, `node_modules`, editor files. Biome ignores build outputs.
- **Package Manager**: Bun for all scripts (faster than npm/yarn).
- **No Advanced Features**: No routing, no API integration, no SSR, no tests, no CI/CD beyond pre-commit hooks.

## Key Files
- `bsconfig.json`: ReScript config (ES6 in-source, jsx automatic, dependencies @rescript/core, @rescript/react).
- `rspack.config.js`: Bundler config (entry `main.bs.js`, SWC loader for JSX/TS, SVGR for SVGs, React Refresh in dev, HtmlRspackPlugin with index.html).
- `package.json`: Scripts and deps (ReScript, React 18, Emotion, Rspack, Biome, Husky, Commitizen, etc.).
- `biome.json`: Linting/formatting rules, ignores build outputs.
- `tsconfig.json`: TypeScript for JSX interop (react-jsx, ESNext modules).
- `commitlint.config.js`: Extends @commitlint/config-conventional.
- `.husky/pre-commit`: Runs format and lint.
- `.husky/commit-msg`: Runs commitlint.
- `index.html`: Template with #root div, favicon /react.svg.
- `src/react-env.d.ts`: TypeScript declarations for CSS modules (if used).

Avoid editing `.bs.js` files directly; they are generated from `.res` and ignored in git.