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
-- 	{
-- 		'akinsho/bufferline.nvim',
-- 		version = "*", 
-- 		dependencies = 'nvim-tree/nvim-web-devicons',
-- 		config = function()
-- 			vim.opt.termguicolors = true
-- 		require("bufferline").setup({
--     options = {
--         mode = "buffers",
--         diagnostics = "nvim_lsp",
--         numbers = function(opts)
--             return string.format("%s", opts.raise(opts.ordinal))
--         end,
--         themable = false,
--         separator_style = "slant",
--
--     },
--     highlights = {
--         background = { fg = "#6e6e6e" },
--         separator = { fg = "#111111", bg = "#111111" },  
--         separator_visible = { fg = "#111111" },
--         separator_selected = { fg = "#111111" }
--     }
-- })
-- end 
-- },
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
require('lualine').setup({
    options = {
        theme = 'powerline_dark',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } }, 
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 
            { 
                'filename', 
                path = 1, 
color = { fg = '#bbbbbb' }
            } 
        }, 
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    }
})
		end,
	}
} 
