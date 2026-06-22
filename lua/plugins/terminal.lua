return {
    'akinsho/toggleterm.nvim',
    version = "*",
		  config = function()
		      require("toggleterm").setup({
		          open_mapping = [[<C-'>]],
		      })

		      -- Jump TO the terminal and guarantee Terminal-Insert mode
		      vim.keymap.set("n", "<C-CR>", function()
		          for _, win in ipairs(vim.api.nvim_list_wins()) do
		              local buf = vim.api.nvim_win_get_buf(win)
		              if vim.bo[buf].filetype == "toggleterm" then
		                  vim.api.nvim_set_current_win(win)
		    vim.schedule(function()
			    vim.cmd("startinsert") -- This forces Terminal-Insert mode
		    end)
		                  return
		              end
		          end
		          -- If no terminal window is open, create one
		          vim.cmd("ToggleTerm")
		      end, { noremap = true, silent = true })

		      -- Jump AWAY from the terminal back to your editor window
		      vim.keymap.set("t", "<C-CR>", function()
			vim.cmd("stopinsert")
			vim.cmd("wincmd p")
		end
		, { noremap = true, silent = true })
	end
	 
}
