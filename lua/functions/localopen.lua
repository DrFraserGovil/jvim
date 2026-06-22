-- :e queries files relative to the root directory of the project; this provides a wrapper that opens files relative to the current file
vim.api.nvim_create_user_command("E", function(opts)
		local dir = vim.fn.expand("%:p:h")
		vim.cmd.edit(dir .. "/" .. opts.args)
	end, {
	nargs = 1,
	complete = function(arglead)
		local dir = vim.fn.expand("%:p:h")
		local matches = vim.fn.glob(dir .. "/" .. arglead .. "*", false, true)
		local results = {}
		for _, m in ipairs(matches) do
			table.insert(results, m:sub(#dir + 2))  -- strip the dir prefix back off
		end
		return results
	end,
})
