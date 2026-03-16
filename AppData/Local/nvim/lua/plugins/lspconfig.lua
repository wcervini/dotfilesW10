return {
	"hrsh7th/cmp-nvim-lsp",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Astro
		vim.lsp.config("astro", {
			capabilities = capabilities,
		})

		-- TypeScript/JavaScript
		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		})

		-- Vue.js
		vim.lsp.config("volar", {
			capabilities = capabilities,
			filetypes = { "vue" },
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})

		-- Python
		vim.lsp.config("pyright", {
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		-- Lua
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- Markdown
		vim.lsp.config("marksman", {
			capabilities = capabilities,
		})

		-- Habilitar todos los servidores
		vim.lsp.enable({ "astro", "ts_ls", "volar", "pyright", "lua_ls", "marksman" })

		-- Comando :LspInfo para Neovim 0.11+
		vim.api.nvim_create_user_command("LspInfo", function()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if #clients == 0 then
				vim.notify("No hay LSP activo en este buffer", vim.log.levels.WARN)
				return
			end
			local lines = { "LSP activos:" }
			for _, client in ipairs(clients) do
				table.insert(lines, string.format("  - %s (id: %d)", client.name, client.id))
			end
			vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
		end, { desc = "Mostrar LSP activos en el buffer actual" })
	end,
}
