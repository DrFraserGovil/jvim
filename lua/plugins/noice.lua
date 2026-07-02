return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        cmdline = {
          view = "cmdline", -- classic bottom position, not a floating popup
        },
        messages = {
          enabled = true,
          view = "mini", -- small, non-blocking notification instead of the "Press ENTER" prompt
        },
        notify = {
          enabled = true,
        },
        routes = {
          {
            filter = {
              event = "lsp",
              kind = "progress",
              cond = function(message)
                -- Safely catch Pyright text anywhere in the progress client names
                local client = message.opts and message.opts.progress and message.opts.progress.client
                return client and string.find(client:lower(), "pyright") ~= nil
              end,
            },
            opts = { skip = true },
          },
        },
      })
    end,
  },
}
