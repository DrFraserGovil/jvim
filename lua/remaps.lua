-- Escape remap
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "<C-space>",  "<Esc>")
vim.keymap.set("x", "<C-space>",  "<Esc>")
local directional_modes = { "n", "v", "o" }

-- Remap HJKL to be powerful versions of hjkl
vim.keymap.set(directional_modes, "H", "^")
vim.keymap.set(directional_modes, "J", "L")
vim.keymap.set(directional_modes, "K", "H")
vim.keymap.set(directional_modes, "L", "g_")

-- line wrapping remaps for gj/gk and j/k that keep working when given counts
vim.keymap.set({ "n", "x" }, "j", function()
    return vim.v.count > 0 and "j" or "gj"
end, { expr = true, remap = true, silent = true })

vim.keymap.set({ "n", "x" }, "k", function()
    return vim.v.count > 0 and "k" or "gk"
end, { expr = true, remap = true, silent = true })

-- Send 'x' to the black hole, we rarely want to yank it!
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
-- Reassign unused or duplicated keys to more useful things 
vim.keymap.set(directional_modes, "£", "#")
vim.keymap.set(directional_modes, "\\", "$")
vim.keymap.set({ "n", "x" },"0","\"0p") -- paste the last *yank*, even after deletes/changes have overwritten the clipboard
vim.keymap.set("n", "$","za",{remap=true})
vim.keymap.set("n", "^","zR",{remap=true})
vim.keymap.set("n", "_","zM",{remap=true})
vim.keymap.set("n", "U", "<C-r>")
 
-- Swap ` and . (Mark jump vs Repeat action)
-- mark jumps are motions, so they also apply in operator-pending/visual (d.a); repeat only exists in normal mode
vim.keymap.set({ "n", "o", "x" }, ".", "`")
vim.keymap.set("n", "`", ".")

-- Swap ' and , (Line mark jump vs Inline find character reverse) -- both are motions, so swap everywhere
vim.keymap.set({ "n", "o", "x" }, ",", "'")
vim.keymap.set({ "n", "o", "x" }, "'", ",")

-- Swap forward and backward to batch right/left pattern
vim.keymap.set("n","<C-i>","<C-o>")
vim.keymap.set("n","<C-o>","<C-i>")

-- basic indent
vim.keymap.set("n","<M-]>",">>")
vim.keymap.set("n","<M-[>","<<")
vim.keymap.set("v","<M-]>",">gv")
vim.keymap.set("v","<M-[>","<gv")

-- set insert mode ctrl-v: insert the clipboard literally at the cursor (works at column 0, no auto-indent mangling)
vim.keymap.set("i","<C-v>","<C-r><C-o>+")
vim.keymap.set("i","<C-x>","<C-v>")
