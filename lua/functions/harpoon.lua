local M = {}

-- A path made absolute with symlinks resolved, so ~/docs/... and ~/Documents/... compare equal
local function real(path)
	return vim.uv.fs_realpath(vim.fn.fnamemodify(path, ":p")) or path
end
M.real = real

-- Every occupied slot, in order. harpoon2 leaves a gap (nil) where an item is removed, and ipairs stops at the first gap, so
-- nothing should loop over list.items directly
local function slots(list)
	local out = {}
	for i = 1, list:length() do
		local item = list:get(i)
		if item then table.insert(out, { index = i, item = item }) end
	end
	return out
end
M.slots = slots

-- Closes the gaps, so later files move up a slot (remove the call in toggle_add to keep slot numbers fixed instead)
local function compact(list)
	local items = {}
	for _, slot in ipairs(slots(list)) do table.insert(items, slot.item) end
	list.items, list._length = items, #items
end

function M.clear_harpoon()
	require("harpoon"):list():clear()
	vim.cmd("redrawtabline")
	print("Whales away!")
end

function M.toggle_add()
	local list = require("harpoon"):list()
	local current = real(vim.api.nvim_buf_get_name(0))
	for _, slot in ipairs(slots(list)) do
		if real(slot.item.value) == current then
			list:remove_at(slot.index)
			compact(list)
			print("Harpoon detached")
			vim.cmd("redrawtabline")
			return
		end
	end
	list:add()
	print("Harpoon launched")
	vim.cmd("redrawtabline")
end

-- Jumps to slot idx: to the window already showing it if there is one, else opens it here
function M.smart_select(idx)
	local list = require("harpoon"):list()
	local item = list:get(idx)
	if not item then return end
	local target = real(item.value)
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if real(vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))) == target then
			vim.api.nvim_set_current_win(win)
			return
		end
	end
	list:select(idx)
end

vim.api.nvim_create_user_command("HarpoonRelease", M.clear_harpoon, { nargs = 0 })
vim.api.nvim_create_user_command("HarpoonToggle", M.toggle_add, { nargs = 0 })

return M
