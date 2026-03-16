return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	init = function()
		-- Configurar CC antes de cargar treesitter (Windows fix)
		vim.env.CC = "gcc"
	end,
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				-- Lenguajes solicitados
				"astro",
				"typescript",
				"tsx",
				"javascript",
				"python",
				"lua",
				"markdown",
				"markdown_inline",
				"vue",
				-- Lenguajes comunes adicionales
				"html",
				"css",
				"scss",
				"json",
				"jsonc",
				"yaml",
				"toml",
				"bash",
				"vim",
				"vimdoc",
				"regex",
				"query",
			},
			sync_install = false,
			auto_install = true,
		})

		-- Activar highlight y indent automáticamente
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ok = pcall(vim.treesitter.start, args.buf)
				if ok then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
