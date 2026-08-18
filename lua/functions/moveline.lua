vim.api.nvim_create_user_command("M", function(opts)
	local arg = opts.args
	if not arg or arg == "" then return end
	print(arg)
	local sign, count_str = string.match(arg,"^([%+-]?)(%d+)$")
    local count = tonumber(count_str)
    
    if not count then
        print("Invalid argument. Use format: :M 3, :M +3, or :M -2")
        return
    end
	-- Save initial position
    local start_pos = vim.api.nvim_win_get_cursor(0)

    -- Use native visual motions to let Neovim skip the folds
    local motion = (sign == "-") and "gk" or "gj"
    vim.cmd(string.format("normal! %d%s", count, motion))

    -- Grab the destination line Neovim landed us on
    local target_line = vim.api.nvim_win_get_cursor(0)[1]

    -- Restore the cursor so the subsequent :move targets the correct line
    vim.api.nvim_win_set_cursor(0, start_pos)

    -- Adjust target if moving upwards since :move places the line *after* the target
    if sign == "-" then
        target_line = target_line - 1
    end

    -- Execute the move and auto-indent
    vim.cmd(string.format("move %d", target_line))
    vim.cmd("normal! ==")
end, {nargs=1})
