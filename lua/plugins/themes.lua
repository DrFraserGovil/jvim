return {

		{
			"Mofiqul/vscode.nvim",
			priority = 1000,  -- load early; colorschemes need to be available before other plugins render
			config = function()
				require("vscode").setup({
					-- transparent = false,
					-- italic_comments = true,
					-- (check the plugin's README for available options)
				})
				vim.cmd("colorscheme vscode")
			end,
		},
		{
			'akinsho/bufferline.nvim',
			version = "*", 
			dependencies = 'nvim-tree/nvim-web-devicons',
			config = function()
				vim.opt.termguicolors = true
				require("bufferline").setup{options={
					diagnostics = "nvim_lsp",
					numbers = function(opts)
						return string.format("%s",opts.raise(opts.ordinal))
					end,
					themable=false,
					separator_style="slant",
				},
				highlights={
					background = { fg = "#6e6e6e" },
					separator = {fg ="#111111",bg="#111111"},  
separator = {
            fg = "#111111", -- Force the triangle background space to blend into your fill
        },
        separator_visible = {
            fg = "#111111",
        },
        separator_selected = {
            fg = "#111111",
        }
				}

			}

			end
		}
} 
