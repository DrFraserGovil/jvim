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
				require("bufferline").setup{}
			end
		}
} 
