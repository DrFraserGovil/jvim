

local function apply_define_source()
	-- Pure string substitution on the current line
	local line = vim.api.nvim_get_current_line()
	local clean_text = line:gsub("//.*", "") -- Ignore trailing comments
	local semi_idx = clean_text:match(".*();")
	if not semi_idx then
		vim.notify("No structural semicolon found on this line", vim.log.levels.ERROR)
		return
	end
	-- Swap the semicolon for brackets without moving the cursor position
	local new_line = line:sub(1, semi_idx - 1) .. "{}" .. line:sub(semi_idx + 1)
	vim.api.nvim_set_current_line(new_line)
	-- Trigger LSP code action and auto-apply if possible
	vim.lsp.buf.code_action({ apply = true })
end


local function complete_symbols(arg_lead)
	local seen, matches = {}, {}
	for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
		local clean = line:gsub("//.*", "")
		local name = clean:match("([%w_:]+)%s*%([^()]-%)[^;]*;")
		if name and not seen[name] and vim.startswith(name, arg_lead) then
			seen[name] = true
			table.insert(matches, name)
		end
	end
	return matches
end

vim.api.nvim_create_user_command("DefineSource", function(cmd)
	-- check if in a cpp buffer
	if vim.bo.filetype ~= "cpp" then
		vim.notify(
			string.format("DefineSource only works on cpp buffers (current filetype: '%s')", vim.bo.filetype),
			vim.log.levels.ERROR
		)
		return
	end

	-- optional argument: jump to the first match before running the same logic
	if cmd.args ~= "" then
		local saved_pos = vim.api.nvim_win_get_cursor(0)
		vim.fn.cursor(1, 1) -- search deterministically from the top of the buffer
		local pattern = vim.fn.escape(cmd.args, "\\/.*$^~[]")
		local found = vim.fn.search(pattern, "cW") -- c: allow match at (1,1), W: don't wrap
		if found == 0 then
			vim.notify(string.format("No match for '%s' found in buffer", cmd.args), vim.log.levels.WARN)
			vim.api.nvim_win_set_cursor(0, saved_pos)
			return
		end
	end

	apply_define_source()
end, {
	nargs = "*", 
	complete= complete_symbols,
	desc = "Generate a stub definition for the .h declaration on the current line (or the first line matching <args>)",
})
