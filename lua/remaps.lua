-- Escape remap
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "<C-space>",  "<Esc>")
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
 
-- Reassign unused or duplicated keys to more useful things 
vim.keymap.set(directional_modes, "£", "#")
vim.keymap.set(directional_modes, "\\", "$")
vim.keymap.set(directional_modes,"0","\"0p")
vim.keymap.set("n", "$","za",{remap=true})
vim.keymap.set("n", "^","zR",{remap=true})
vim.keymap.set("n", "_","zM",{remap=true})
vim.keymap.set("n", "U", "<C-r>")
 
-- Swap ` and . (Mark jump vs Repeat action)
vim.keymap.set("n", ".", "`")
vim.keymap.set("n", "`", ".")

-- Swap ' and , (Line mark jump vs Inline find character reverse)
vim.keymap.set("n", ",", "'")
vim.keymap.set("n", "'", ",")


-- basic indent
vim.keymap.set("n","<M-]>",">>")
vim.keymap.set("n","<M-[>","<<")
vim.keymap.set("v","<M-]>",">gv")
vim.keymap.set("v","<M-[>","<gv")
