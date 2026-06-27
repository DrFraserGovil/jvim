vim.api.nvim_create_user_command("Todo", function(opts)

	vim.cmd("Telescope todo-comments")
	vim.cmd("stopinsert")
end, {nargs=0})
