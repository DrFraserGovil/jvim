
vim.api.nvim_create_user_command("ClearBuffers", function()
	local visible_bufs = {}
    
    -- 1. Map all buffers currently assigned to any open window across all tabs
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        visible_bufs[vim.api.nvim_win_get_buf(win)] = true
    end

    local closed_count = 0
    
    -- 2. Scan every buffer loaded in Neovim
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Only target valid, listed buffers that aren't visible
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and not visible_bufs[buf] then
            -- Safe guard: skip buffers with unsaved modifications
            if not vim.bo[buf].modified then
                vim.api.nvim_buf_delete(buf, {})
                closed_count = closed_count + 1
            end
        end
    end

    print(string.format("Buffers cleaned: Closed %d hidden buffer(s)", closed_count))
end, {nargs = 0})
