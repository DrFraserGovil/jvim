local directional_modes = { "n", "v", "o" }
-- Join and break lines
vim.keymap.set("n", "<leader>j", "J")
vim.keymap.set("n", "<leader>k", "i<CR><Esc>k$")

-- Insert lines, keeping indent
vim.keymap.set('n', '<CR>', 'o<Space><Esc>', { noremap = true })
vim.keymap.set('n', '<S-CR>', 'O<Space><Esc>', { noremap = true })
vim.keymap.set('v', '<CR>', '<Esc>o<Space><Esc>gv', { noremap = true })
vim.keymap.set('v', '<S-CR>', '<Esc>O<Space><Esc>gv', { noremap = true })
 
-- Move lines 
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==") -- Move line down and re-indent
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==") -- Move line up and re-indent
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")     -- Move selection down and re-indent
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")     -- Move selection up and re-indent
 
-- File saving
vim.keymap.set("i", "<C-s>","<Esc>:w<CR>")
vim.keymap.set(directional_modes, "<C-s>","<Esc>:w<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
 
-- Whole document operations 
vim.keymap.set("n", "<leader>a", ":%y<CR>")
 
-- Window  and buffer navigation
require("functions/moveto")
for i = 1, 9 do
	vim.keymap.set("n", "<C-" .. i .. ">", i .. "<C-w>w", { desc = "Go to window " .. i })
	vim.keymap.set("n", "<M-" .. i .. ">", "<Cmd>BufferLineGoToBuffer" .. i .. "<CR>", { desc = "Go to buffer " .. i })
	vim.keymap.set("n","<leader>m" .. i, function()
	moveBuffer(i)
	end)
end
vim.keymap.set("n","<c-\\>",":vs<cr>:bp<cr><c-w>l")

-- comments
vim.keymap.set("n", "<leader>q","<Esc>ihi")


