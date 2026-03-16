# Neovim Configuration - Agent Guidelines

This repository contains a personal Neovim configuration using lazy.nvim as the plugin manager.
It is primarily a Lua-based configuration directory, not a traditional application codebase.

## Project Structure

```
nvim/
├── init.lua              # Entry point - loads all config modules
├── lazy.lua              # Lazy.nvim bootstrap (standalone)
├── lua/
│   ├── config/           # Core configuration modules
│   │   ├── options.lua   # Vim options (tabs, encoding, shell)
│   │   ├── keymaps.lua   # Key mappings
│   │   ├── autocmd.lua   # Autocommands
│   │   ├── lazy.lua      # Lazy.nvim setup and plugin loading
│   │   ├── funciones.lua # Utility functions (Spanish naming)
│   │   └── commits_functions.lua # Git commit helpers
│   └── plugins/          # Plugin specifications (lazy.nvim format)
├── CHANGELOG.md          # Version history
└── VERSION               # Current version
```

## Commands

### Validation and Testing

```bash
# Check Lua syntax (from repository root)
luacheck lua/ --globals vim

# Validate Neovim configuration
nvim --headless -c "lua print('Config OK')" -c "qa"

# Check for Lua errors in config
nvim --headless -c "checkhealth" -c "qa"

# Run stylua formatter check (dry-run)
stylua --check lua/

# Format all Lua files
stylua lua/
```

### Plugin Management (inside Neovim)

```vim
:Lazy              " Open lazy.nvim UI
:Lazy sync         " Update all plugins
:Lazy health       " Check plugin health
:Mason             " Open Mason package manager
:checkhealth       " Run Neovim health checks
```

## Code Style Guidelines

### Lua Formatting

- **Formatter**: stylua (configured via conform.nvim)
- **Indentation**: Tabs converted to 2 spaces
- **Line width**: No hard limit, but keep readable
- **Trailing commas**: Use in multi-line tables

### Module Structure

All Lua modules should follow this pattern:

```lua
-- lua/config/example.lua
local M = {}

M.function_name = function()
    -- implementation
end

return M
```

### Plugin Specifications

Plugins use lazy.nvim format. Return a table or list of tables:

```lua
-- lua/plugins/example.lua
return {
    "author/plugin-name",
    dependencies = { "dep/plugin" },
    event = { "BufReadPre", "BufNewFile" },  -- Lazy loading
    opts = {
        -- Plugin options
    },
    config = function()
        -- Complex setup
    end,
}
```

### Naming Conventions

- **Files**: lowercase with underscores (e.g., `commits_functions.lua`)
- **Variables**: snake_case for locals, UPPER_CASE for constants
- **Functions**: snake_case (e.g., `abrir_borrador`, `get_pnpm_tsdk`)
- **Modules**: Return table named `M` by convention
- **Comments**: Spanish or English acceptable (project uses both)

### Imports and Requires

```lua
-- Standard pattern for requiring modules
local M = {}
local utils = require("config.funciones")

-- For vim APIs
local api = vim.api
local fn = vim.fn
local opt = vim.opt
```

### Keymap Definitions

Use the helper function from `config/funciones.lua`:

```lua
local opt = require("config.funciones").opts
local k = vim.keymap.set

k("n", "<leader>example", function() end, opt("Description here"))
```

### Error Handling

```lua
-- Check shell command success
local result = vim.fn.system("command")
if vim.v.shell_error ~= 0 then
    print("Error: descriptive message")
    return
end

-- Check file handles
local handle = io.popen("command")
if not handle then
    return nil
end
local output = handle:read("*a") or ""
handle:close()
```

### Autocommands

```lua
vim.api.nvim_create_autocmd("EventName", {
    pattern = { "*.ext" },
    callback = function(ev)
        -- handler
    end,
})
```

## Linting and Formatting

### Configured Linters (nvim-lint)

| Language   | Linter   |
|------------|----------|
| Python     | ruff     |
| JavaScript | eslint   |
| Lua        | luacheck |

### Configured Formatters (conform.nvim)

| Language     | Formatter(s)           |
|--------------|------------------------|
| Lua          | stylua                 |
| Python       | isort, black           |
| JS/TS/Vue    | prettierd, prettier    |
| HTML/CSS     | prettierd, prettier    |
| Go           | goimports, gofmt       |
| Django HTML  | djlint                 |
| Rust         | rustfmt                |

## Dependencies

### Required External Tools

Install via npm/pnpm globally:
- @astrojs/language-server
- typescript, typescript-language-server
- vscode-langservers-extracted
- pyright
- marksman

Install via Mason (:Mason in Neovim):
- black, isort, prettier, prettierd, djlint
- stylua, luacheck, eslint, ruff

### System Requirements

- Neovim 0.11+
- Git
- ripgrep (for Telescope)
- fd (for file finding)
- Node.js (for LSP servers)
- Python 3.12+ (for Python tools)

## Git Workflow

### Commit Message Format

Follow conventional commits (see CHANGELOG.md):

```
type(scope): description

- fix: Bug fixes
- feat: New features  
- refactor: Code restructuring
- chore: Maintenance tasks
```

### Draft Commits

This config includes a draft commit system:
- `<leader>jn` - Open draft notes in `.git/COMMIT_DRAFT`
- `<leader>jc` - Create commit using draft notes

## Important Notes

- Shell is configured for PowerShell (`pwsh`)
- File format defaults to Unix (`fileformat = "unix"`)
- Encoding is UTF-8
- ShaDa is disabled for faster startup
- Format on save is enabled via conform.nvim
