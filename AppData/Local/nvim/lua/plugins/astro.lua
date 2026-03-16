return {
	"wuelnerdotexe/vim-astro",
	event = { "BufReadPre *.astro", "BufNewFile *.astro" },
	config = function()
		vim.g.astro_typescript = "enable"
	end,
}
