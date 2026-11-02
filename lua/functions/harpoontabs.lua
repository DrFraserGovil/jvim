local function harpoon_tabline()
	local custom = require("functions/harpoon")
	local current_path = custom.real(vim.api.nvim_buf_get_name(0))

	local s = ""
	-- the pinned slots, skipping any gaps left by removals
	for _, slot in ipairs(custom.slots(require("harpoon"):list())) do
		local file_name = vim.fn.fnamemodify(slot.item.value, ":t")
		if file_name == "" then file_name = "[No Name]" end

		-- highlight the active slot so you know where you are
		local group = custom.real(slot.item.value) == current_path and "%#TabLineSel#" or "%#TabLine#"
		s = s .. group .. " [" .. slot.index .. "] " .. file_name .. " "
	end

	-- fill the rest of the bar with the standard background colour
	return s .. "%#TabLineFill#"
end

-- wire the function directly into Neovim's native global tabline option
vim.opt.showtabline = 2 -- always show the tabline
_G.get_harpoon_tabline = harpoon_tabline
vim.opt.tabline = "%!v:lua.get_harpoon_tabline()"
