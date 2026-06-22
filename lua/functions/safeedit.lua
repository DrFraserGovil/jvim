vim.api.nvim_create_user_command("SafeEdit", function(opts)
  local function is_normal_window(win)
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then
      return false -- floating window: lazy, telescope, notify, etc.
    end
    local buf = vim.api.nvim_win_get_buf(win)
    return vim.bo[buf].buftype == "" -- "" = a normal, real file buffer
  end

  -- already in a usable window? just open it here
  if is_normal_window(vim.api.nvim_get_current_win()) then
    vim.cmd("edit " .. vim.fn.fnameescape(opts.args))
    return
  end

  -- otherwise hunt for any normal window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if is_normal_window(win) then
      vim.api.nvim_set_current_win(win)
      vim.cmd("edit " .. vim.fn.fnameescape(opts.args))
      return
    end
  end

  -- nothing suitable exists: make a fresh split
  vim.cmd("new " .. vim.fn.fnameescape(opts.args))
end, { nargs = 1, complete = "file" })
