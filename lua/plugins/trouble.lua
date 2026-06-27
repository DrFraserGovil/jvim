return {
{
  "folke/trouble.nvim",
  cmd = "Trouble",
  config = function()
	require("trouble").setup({
		focus=true,
		modes = {
			mixed = {
				sections = { "qflist", "diagnostics"} 
			}
		}

	})
  end
}

}

