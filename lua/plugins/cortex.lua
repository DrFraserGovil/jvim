return {
        {
                dir = "~/Documents/Personal/cortex/editor/nvim",
                name = "cortex",
                lazy = false, -- the .ctx filetype rule must exist before the first note opens
                config = function()
                        require("cortex").setup({
                                cmd = { "/home/frasergj/Tools/cortex", "lsp" }, -- only if Neovide can't find cortex
                        })
                        -- gd for "go to the linked note" in notes (in Neovim 0.11, gd isn't an LSP mapping by default)
                        vim.api.nvim_create_autocmd("FileType", {
                                pattern = "cortex",
                                callback = function(args)
                                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "CorTeX: go to the linked note" })
                                end,
                        })
                end,
        },
}
