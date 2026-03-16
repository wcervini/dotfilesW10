vim.g.mapleader = " "
vim.g.localmapleader = "\\"

-- Filetype detection (antes de cargar plugins)
vim.filetype.add({
	extension = {
		astro = "astro",
	},
})

-- Habilitar filetype detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

require("config.options")
require("config.keymaps")
require("config.commits_functions")
require("config.autocmd")
require("config.lazy")
require("config.telescope_tree")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 72
		vim.cmd("startinsert")
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})
