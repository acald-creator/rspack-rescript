Rspack & Rescript with Bun

## How to get started

Ensure you have `bun` installed on your local machine.

Run `bun install` to install dependencies.

To build `rescript` files

```bash
bun run res:build
```

To build `rspack` for production

```bash
bun run build
```

To test your local changes, run `bun run res:build` to build the `rescript` files

And then

```bash
bun run res:dev
```

in order to see your local changes at `http://localhost:8080`
