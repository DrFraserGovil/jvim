vim.api.nvim_create_user_command("TSReset", function()
    vim.treesitter.stop()
    vim.treesitter.start()
end, { desc = "Force a full Tree-sitter reparse of the current buffer" })
 vim.api.nvim_create_autocmd("FileType", {
  desc = "Automatically start Tree-sitter highlighting",
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
