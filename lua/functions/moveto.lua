moveBuffer = function(target_winnr)
  local current_win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  local target_win = vim.fn.win_getid(target_winnr)
  if target_win == 0 then return end -- invalid window number
  vim.api.nvim_set_current_win(target_win)
  vim.cmd("buffer " .. buf)
  vim.api.nvim_set_current_win(current_win)
  vim.cmd("bprevious")
end
