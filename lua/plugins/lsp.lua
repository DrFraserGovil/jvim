return {
	

	{
		"onsails/lspkind.nvim",
	},
	

    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- Prevents the nil error
        config = function()
			 
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.cpp", "*.h", "*.hpp", "*.c" },
    callback = function()
        vim.lsp.buf.format({ async = false }) -- Must be synchronous to finish before the write completes
    end,
})
vim.lsp.config("clangd", {
                cmd = { 
                    "clangd", 
                    "--compile-commands-dir=.build", 
                    "--background-index",
        -- Equivalent to Completion.ArgumentLists: FullPlaceholders
        "--completion-style=detailed",
        -- Equivalent to Completion.HeaderInsertion: Never
        "--header-insertion=never"
                },
                root_markers = { ".git", "compile_commands.json" },
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
            vim.lsp.enable("clangd")
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
				view = {entries = "custom", selection_order="near_cursor",},
				  window = {
    completion = {
      -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = {
      fields = { "icon", "abbr", "menu", "kind" },
      format = function(entry, vim_item)
          local lspkind = require("lspkind")
          local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          kind.icon = " " .. (kind.icon or "") .. "  "
          kind.kind = "   (" .. (kind.kind or "") .. ")"

          return kind
      end,
  },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body) -- Uses Neovim's native snippet engine
                    end,
                },
                mapping = cmp.mapping.preset.insert({
					["<C-Tab>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-q>"] = cmp.mapping.abort()
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
}

