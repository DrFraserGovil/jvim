local M = {}

M.clear_harpoon = function()
	local harpoon = require("harpoon")
    local list = harpoon:list()
   
	harpoon:list():clear()
    vim.cmd("redrawtabline")
    
    print("Whales Away!")
end

M.toggle_add = function()

    local harpoon = require("harpoon")
    local list = harpoon:list()
    local current_file = vim.api.nvim_buf_get_name(0)
    
    -- Harpoon stores paths relative to the project root, so we normalize them 
    -- to absolute paths before checking for a match
    local found_idx = nil
    for idx, item in ipairs(list.items) do
        if vim.fn.fnamemodify(item.value, ":p") == current_file then
            found_idx = idx
            break
        end
    end

    if found_idx then
        -- File is already in the list, so remove it
        list:remove_at(found_idx)
        print("Harpoon Launched!")
    else
        -- File isn't in the list, so add it
        list:add()
        print("Harpoon Detached!")
    end
	 vim.cmd("redrawtabline")
end
function M.smart_select(idx)
    local harpoon = require("harpoon")
    local list = harpoon:list()
    local item = list.items[idx]

    -- If the slot is empty, abort early
    if not item then
        return
    end

    -- Expand the Harpoon path to an absolute path for strict matching
    local target_path = vim.fn.fnamemodify(item.value, ":p")
    local wins = vim.api.nvim_tabpage_list_wins(0)

    -- Check if the target file is already displayed in an open window
    for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local path = vim.api.nvim_buf_get_name(buf)
        
        if vim.fn.fnamemodify(path, ":p") == target_path then
            -- Hop directly to that window and finish
            vim.api.nvim_set_current_win(win)
            return
        end
    end

    -- Fallback: If it's not open anywhere on screen, open it in the current window
    list:select(idx)
end
vim.api.nvim_create_user_command("HarpoonRelease", function()
	M.clear_harpoon()
end,{nargs= 0})
vim.api.nvim_create_user_command("HarpoonToggle", function()
	M.toggle_add()
end,{nargs= 0})

return M
