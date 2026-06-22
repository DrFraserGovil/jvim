require("remaps") 		-- move around basic vim keybindings to new keys
require("keybindings")		-- add in new keybindings
require("functions/localopen")  -- open files relative to the current file 
require("functions/safeedit")	-- opens a buffer after moving to a non-terminal window
 
-- standard stuff
vim.opt.ignorecase = false
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.number = true --so that the current line is numbered

-- softer autocomplete
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
 

-- Highlight text on yank (copy)
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Briefly highlight yanked text",
    group = vim.api.nvim_create_augroup("clear_highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150,         -- ms duration 
        })
    end,
})


vim.opt.shiftwidth=4
vim.opt.tabstop=4

