local function harpoon_tabline()
    local harpoon = require("harpoon")
    local entries = harpoon:list().items
    local current_buf = vim.api.nvim_get_current_buf()
    local current_path = vim.api.nvim_buf_get_name(current_buf)

    local s = ""
    
    -- Loop through the pinned Harpoon slots
    for idx, item in ipairs(entries) do
        local file_name = vim.fn.fnamemodify(item.value, ":t")
        if file_name == "" then file_name = "[No Name]" end

        -- Expand the stored relative path to check if it's the active buffer
        local full_item_path = vim.fn.fnamemodify(item.value, ":p")
        
        -- Highlight the active slot so you know where you are
        if full_item_path == current_path then
            s = s .. "%#TabLineSel# [" .. idx .. "] " .. file_name .. " "
        else
            s = s .. "%#TabLine# [" .. idx .. "] " .. file_name .. " "
        end
    end
    
    -- Fill the rest of the bar with the standard background color
    return s .. "%#TabLineFill#"
end

-- Wire the function directly into Neovim's native global tabline option
vim.opt.showtabline = 2 -- Always show the tabline
_G.get_harpoon_tabline = harpoon_tabline
vim.opt.tabline = "%!v:lua.get_harpoon_tabline()"
