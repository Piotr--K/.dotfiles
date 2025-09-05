# Neovim ESLint and Formatting Configuration Knowledge

This document captures the current setup and understanding of how ESLint, formatting, and LSP work together in this Neovim configuration.

## Current Setup Overview

### LSP Configuration for Node.js
- **Language Server**: `ts_ls` (TypeScript Language Server) handles JavaScript/TypeScript files
- **Location**: `lua/user/lsp_servers.lua:15`
- **ESLint LSP**: Currently commented out (`-- eslint = {}`)

### Formatting Setup (Conform.nvim)
**Location**: `lua/user/formatter.lua`

```lua
javascript = { "eslint_d", "prettier", stop_after_first = true  },
typescript = { "eslint_d", "prettier", stop_after_first = true  },
```

**Key Features**:
- **eslint_d** runs first, **prettier** as fallback (`stop_after_first = true`)
- **Auto-format on save** enabled by default (`BufWritePre` autocmd)
- **Project rules integration**: Automatically picks up `.eslintrc.*`, `.prettierrc.*` files
- **LSP fallback**: Falls back to LSP formatting if formatters unavailable (`lsp_fallback = true`)
- **Manual formatting**: `<leader>pp` for manual format
- **Toggle**: `<leader>fs` to toggle format-on-save

### Linting Setup (nvim-lint)
**Location**: `lua/user/linters.lua`

```lua
javascript = {'eslint'},
typescript = {'eslint'},
javascriptreact = {'eslint'},
typescriptreact = {'eslint'},
```

- Runs ESLint for diagnostics on `BufWritePost` (after save)
- Uses project's ESLint configuration

## What is eslint_d?

**eslint_d** is a daemon version of ESLint that provides:
- **Speed**: Runs ESLint in persistent background process (avoids startup overhead)
- **Same functionality**: Uses identical rules and configs as regular ESLint
- **Project integration**: Automatically finds and uses project's ESLint configuration

### Rules Used by eslint_d
For the token-gating-service project:

**Configuration Source**: `.eslintrc.js` extends `@rakutenbcl/eslint-config-typescript-rbl`

**Rule Hierarchy**:
1. **Rakuten's custom config** (`@rakutenbcl/eslint-config-typescript-rbl`)
2. **Airbnb TypeScript** rules (`eslint-config-airbnb-typescript`)
3. **TypeScript ESLint** rules (`@typescript-eslint/eslint-plugin`)
4. **Import rules** (`eslint-plugin-import`)

eslint_d provides **identical rule enforcement** to running `npm run lint:fix` - just faster.

## LSP Formatting

**LSP formatting** is code formatting performed by the Language Server Protocol server.

### How it works:
- LSP server (`ts_ls`) provides built-in formatting capabilities
- Triggered via `vim.lsp.buf.format()` or `:Format` command
- Uses server's internal formatter (TypeScript's built-in formatting)

### In this config:
- `:Format` command available (defined in `lua/user/lsp_servers.lua:93-95`)
- Acts as fallback when Conform formatters fail

### Formatting Hierarchy:
1. **Primary**: Conform.nvim (`eslint_d` → `prettier`)
2. **Fallback**: LSP formatting

## Significance of Commenting Out ESLint LSP

Current state: `-- eslint = {}` in `lua/user/lsp_servers.lua:17`

### What you lose:
- **Real-time diagnostics** - No live error/warning squiggles while typing
- **ESLint-specific code actions** - No quick fixes like "disable rule for line"
- **Integrated ESLint commands** - No LSP-based ESLint operations

### What you still have:
- **Linting on save** via nvim-lint
- **Formatting** via eslint_d in Conform
- **ESLint rules enforcement** during formatting

### Why it's commented out:
1. **Performance** - Avoids duplicate ESLint processes (LSP + nvim-lint + eslint_d)
2. **Conflicts** - Multiple ESLint instances can interfere
3. **Preference** - File-based linting vs real-time diagnostics

### Current Workflow:
- **While typing**: No ESLint feedback
- **On save**: ESLint runs via nvim-lint (shows diagnostics)
- **On format**: ESLint rules applied via eslint_d

## Project Integration

Both `eslint_d` and regular `eslint` automatically discover and use project configuration:
- `.eslintrc.*` files
- `prettier.config.js` or `.prettierrc.*` files  
- `package.json` eslint/prettier configurations

The formatters respect your project's configuration hierarchy and apply the same rules as your npm scripts.

## Summary

This setup provides a layered approach to code quality:
1. **Formatting**: eslint_d + prettier via Conform.nvim (fast, project-aware)
2. **Linting**: ESLint via nvim-lint (post-save diagnostics)
3. **Fallback**: LSP formatting when external formatters fail

The configuration prioritizes performance and avoids conflicts while maintaining full project rule compliance.