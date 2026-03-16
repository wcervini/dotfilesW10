return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		build = ":MasonUpdate",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			max_concurrent_installers = 10,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				-- LSP Servers
				"astro-language-server",
				"typescript-language-server",
				"vue-language-server",
				"pyright",
				"lua-language-server",
				"marksman",
				-- Formatters
				"black",
				"isort",
				"prettier",
				"prettierd",
				"djlint",
				"stylua",
				-- Linters
				"ruff",
				"eslint_d",
				"luacheck",
			},
			auto_update = true,
			run_on_start = true,
		},
	},
}
