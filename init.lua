if vim.g.neovide then
vim.g.neovide_ext_cmdline = false
vim.g.neovide_ext_messages = false
vim.g.encoding="utf-8"
vim.g.fileencoding="utf-8"
end
vim.g.mapleader = " "


require("base")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
 
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})

if vim.g.vscode then
	require("vscode-hooks")
end
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        -- Restores the default 'jump' behavior for Enter in the quickfix window
        vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
    end,
})
