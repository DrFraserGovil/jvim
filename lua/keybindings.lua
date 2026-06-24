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
vim.keymap.set("n","ZZ", ":w<CR>:Bdelete<CR>") 

-- Whole document operations 
vim.keymap.set("n", "<leader>a", ":%y<CR>")
vim.keymap.set("n", "<leader>n", ":noh<CR>") 
vim.keymap.set("n", "<leader>=", "mhggVG==<Esc>`h") --triggers a global reformat
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

vim.keymap.set("n","ge",":bn<CR>")
vim.keymap.set("n","gE",":bp<CR>")

--Comments
vim.keymap.set("n","<C-/>","gcc",{remap=true})
vim.keymap.set("v","<C-/>","gcgv",{remap=true})

-- LSP
vim.keymap.set("n", "Q", function()
	local winid = vim.diagnostic.open_float({ quiet = true })
	-- If winid is nil, no float opened; fall back to LSP hover
	vim.notify(tostring(winid),vim.log.levels.WARN)
	if not winid then
		vim.lsp.buf.hover()
	end
end, { desc = "Show diagnostic float or LSP hover" })
vim.keymap.set("n","<C-e>",vim.diagnostic.open_float)
vim.keymap.set("n","<leader>f",vim.lsp.buf.code_action,{desc="Fix via LSP code actions"})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename symbol" })
vim.keymap.set("n", "<leader>d", function()
	-- 1. Pure string substitution on the current line
	local line = vim.api.nvim_get_current_line()
	local clean_text = line:gsub("//.*", "") -- Ignore trailing comments
	local semi_idx = clean_text:match(".*();")

	if not semi_idx then
		vim.notify("No structural semicolon found on this line", vim.log.levels.WARN)
		return
	end

	-- Swap the semicolon for brackets without moving the cursor position
	local new_line = line:sub(1, semi_idx - 1) .. "{}" .. line:sub(semi_idx + 1)
	vim.api.nvim_set_current_line(new_line)

	-- 2. Trigger LSP code action and auto-apply if possible
	vim.lsp.buf.code_action({ apply = true })
end, { desc = "Generate out-of-line definition" })

vim.keymap.set("n","<leader><CR>","$o{<CR>}<ESC>O")
-- zooming
vim.g.neovide_scale_factor = 1.0

local function change_scale_factor(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set({"n","i","v"}, "<C-=>", function() change_scale_factor(1.05) end, { desc = "Increase font size" })
vim.keymap.set({"n","i","v"}, "<C-->", function() change_scale_factor(1 / 1.05) end, { desc = "Decrease font size" })
vim.keymap.set({"n","i","v"}, "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, { desc = "Reset font size" })


