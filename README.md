Rspack & Rescript with Bun

## Features
- `commitizen`
- `commitlint`
- `biome.js`
- `husky`
- `release-please` (future)

## How to get started

Ensure you have `bun` installed on your local machine.

```bash
curl -fsSL https://bun.sh/install | bash
```

Run `bun install` to install dependencies.

To build `.res` files

```bash
bun run res:build
```

To build for production with `rspack`

```bash
bun run build
```

To test your local changes, run `bun run res:build` to build the `.res` files

And then

```bash
bun run res:dev
```

in order to see your local changes at `http://localhost:8080`

This app is also deployed via Vercel.sh.
