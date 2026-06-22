return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Register clangd using the new native API
			vim.lsp.config("clangd", {
				cmd = { 
					"clangd", 
					"--compile-commands-dir=.build", 
					"--background-index" 
				},
				root_markers = { ".git", "compile_commands.json" },
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			-- Enable the server
			vim.lsp.enable("clangd")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<tab>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
