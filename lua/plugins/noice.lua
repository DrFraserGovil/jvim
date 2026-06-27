return {
{
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
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
  },
}

}
