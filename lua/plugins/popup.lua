return{
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		config = function()
			require("pretty_hover").setup()
			vim.keymap.set("n", "Q", require("pretty_hover").hover, { desc = "Pretty hover" })
			require("render-markdown").setup({
				heading = {
					icons = { "" },
				},
				code = {
					language = false,
				},
				overrides = {
					buftype = {
						nofile = {
							anti_conceal = { enabled = false },
						},
					},
				},
			})		end,
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			opts = {},
		}
	}
