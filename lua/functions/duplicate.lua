local M = {}

function M.line_down()
  vim.cmd('normal! mtyyP`t')
end

function M.line_up()
  vim.cmd('normal! mtyyp`t')
end

function M.block_down()
  local s = vim.fn.line('v')
  local e = vim.fn.line('.')
  local col = vim.fn.col('.')
  if s > e then s, e = e, s end
  vim.cmd('normal! \27')
  local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
  local count = #lines
  vim.api.nvim_buf_set_lines(0, s - 1, s - 1, false, lines)
  vim.api.nvim_win_set_cursor(0, { e + count, col - 1 })
  vim.cmd('normal! gv')
end

function M.block_up()
  local s = vim.fn.line('v')
  local e = vim.fn.line('.')
  local col = vim.fn.col('.')
  if s > e then s, e = e, s end
  vim.cmd('normal! \27')
  local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
  vim.api.nvim_buf_set_lines(0, e, e, false, lines)
  vim.api.nvim_win_set_cursor(0, { s, col - 1 })
  vim.cmd('normal! gv')
end

return M
