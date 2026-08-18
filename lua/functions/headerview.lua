local M = {}
M.organize_cpp_split = function()
    -- 1. Grab the current file extension
    local current_file = vim.api.nvim_buf_get_name(0)
    local ext = current_file:match("^.+(%..+)$")

    if ext ~= ".cpp" and ext ~= ".h" and ext ~= ".hpp" then
        print("Not a C++ source or header file.")
        return
    end

	-- reset the windowing situation
	local wins = vim.api.nvim_tabpage_list_wins(0)
	if #wins > 1 then
		vim.cmd("only")
	end
	vim.cmd("vsplit")

    -- 3. If we started on the header file, move it to the left window
    if ext == ".h" or ext == ".hpp" then
		vim.cmd("wincmd l")
		vim.cmd(" LspClangdSwitchSourceHeader ")
    
    -- 4. If we started on the source file, move it to the right window
    elseif ext == ".cpp" then
		vim.cmd("wincmd h")
        vim.cmd(" LspClangdSwitchSourceHeader ")
    end
end
return M
-- -- Map it to a quick key combination
-- vim.keymap.set("n", "<leader>cx", organize_cpp_split, { desc = "Align C++ Layout (H Left / CPP Right)" })
