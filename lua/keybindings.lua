local directional_modes = { "n", "v", "o" }
-- Join and break lines
	vim.keymap.set("n", "<leader>j", "J")
	vim.keymap.set("n", "<leader>k", "i<CR><Esc>k$")

-- Mode fixes
	vim.keymap.set("v","i","I")
	vim.keymap.set("i", "<Space>","<Space><C-g>u",{noremap=true})

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

	local duplicate = require("functions/duplicate")
	vim.keymap.set("n", "<M-J>", duplicate.line_down) -- duplicate line down
	vim.keymap.set("n", "<M-K>", duplicate.line_up) -- duplicate line down
	vim.keymap.set("x", "<M-J>", duplicate.block_down, { desc = "Duplicate selection down (cursor on original, now below)" })
	vim.keymap.set("x", "<M-K>", duplicate.block_up, { desc = "Duplicate selection up (cursor stays on original)" })


-- File saving
	vim.keymap.set("i", "<C-s>","<Esc>:w<CR>")
	vim.keymap.set(directional_modes, "<C-s>","<Esc>:w<CR>")
	vim.keymap.set("n", "<leader>w", ":w<CR>")
	vim.keymap.set("n","ZZ", ":w<CR>:Bdelete<CR>") 

-- Whole document operations 
	vim.keymap.set("n", "<leader>y", ":%y<CR>")
	vim.keymap.set("n", "<leader>a", "ggVG")
	vim.keymap.set("n", "<leader>n", ":noh<CR>") 
	vim.keymap.set("n", "<leader>=", function() vim.lsp.buf.format({async=true}) end) --triggers a global reformat

	local toggle = require("functions/togglewrap")
	vim.keymap.set("n", "<M-z>",toggle.togglewrap)

-- Window  and buffer navigation
	require("functions/moveto")
	for i = 1, 9 do
		vim.keymap.set("n", "<C-" .. i .. ">", i .. "<C-w>w", { desc = "Go to window " .. i })
		vim.keymap.set("i", "<C-" .. i .. ">", "<Esc>" .. i .. "<C-w>w", { desc = "Go to window " .. i })
		vim.keymap.set("n","<leader>m" .. i, function() moveBuffer(i) end)
	end
	vim.keymap.set("n","ge",":bn<CR>")
	vim.keymap.set("n","gE",":bp<CR>")

	local toggle = require("functions/headerview")
	vim.keymap.set("n", "<M-h>", toggle.organize_cpp_split)

	vim.keymap.set("n","<c-\\>",":vs<cr>:bp<cr><c-w>l",{desc= "Split window vertically without duplicating the buffer"})


--Comments & folding
	vim.keymap.set("i","<C-/>","<Esc>gcc]",{remap=true})
	vim.keymap.set("n","<C-/>","gcc",{remap=true})
	vim.keymap.set("v","<C-/>","gcgv",{remap=true})
	for i = 1, 9 do
		vim.keymap.set('n', '<leader>f' .. i, function()
			vim.cmd('normal! zM' .. i .. 'zr')
			print("Fold level set to " .. i)
		end, { desc = "Collapse to exactly fold level " .. i })
	end
 
 
-- LSP
	vim.keymap.set("n", "Q", function() vim.lsp.buf.hover() end, { desc = "Show LSP hover" })
	vim.keymap.set("n","<C-e>",vim.diagnostic.open_float, {desc = "Show diagnostic float"})
	vim.keymap.set("n","<M-f>",vim.lsp.buf.code_action,{desc="Fix via LSP code actions"})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename symbol" })

	vim.keymap.set("n","<leader><CR>","$o{<CR>}<ESC>O")

-- zooming
	vim.g.neovide_scale_factor = 1.0

	local function change_scale_factor(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end

	vim.keymap.set({"n","i","v"}, "<C-=>", function() change_scale_factor(1.05) end, { desc = "Increase font size" })
	vim.keymap.set({"n","i","v"}, "<C-->", function() change_scale_factor(1 / 1.05) end, { desc = "Decrease font size" })
	vim.keymap.set({"n","i","v"}, "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, { desc = "Reset font size" })


-- Trouble
	vim.keymap.set("n", "<M-e>", ":Trouble mixed toggle<CR>")
	vim.keymap.set("n", "<M-t>", ":Trouble todo toggle<CR>")
 
-- Harpoon
	local harpoonCustom = require("functions/harpoon")
	vim.keymap.set("n","<M-a>",harpoonCustom.toggle_add, {desc= "Toggle the buffer into the harpoon list"}) 
	vim.keymap.set("n", "<M-l>", function() require("harpoon").ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle menu" })
	vim.keymap.set("n", "<M-1>", function() harpoonCustom.smart_select(1) end)
	vim.keymap.set("n", "<M-2>", function() harpoonCustom.smart_select(2) end)
	vim.keymap.set("n", "<M-3>", function() harpoonCustom.smart_select(3) end)
	vim.keymap.set("n", "<M-4>", function() harpoonCustom.smart_select(4) end)
