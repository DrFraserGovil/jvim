return {
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzf-native.nvim',
			'folke/todo-comments.nvim', -- Ensure this is listed as a dependency
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require('telescope.builtin')

			-- Instead of requiring the utils at the very top, define the 
			-- entry_maker function such that it requires the utils 
			-- only when Telescope actually runs.

			telescope.setup({
				defaults = {
					initial_mode = "normal",

					mappings = {
						i = { ["<C-Space>"] = function() vim.cmd("stopinsert") end, },
						n = { ["<C-Space>"] = "close" },
					},
				},
			})

			-- Keymaps
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

		end,    },

		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--glob=!**/_build/**", -- This is the exclusion flag
					},
				},
				highlight = {
					comments_only =false,
				}
			},
			config = function(_,opts)
				require("todo-comments").setup(opts) -- pass the same opts you use in your real spec, if any
				local function todo_custom(picker_opts)
					-- local Config = 
					local Config = require("todo-comments.config")
					-- if not Config.loaded then
					-- 	require("todo-comments").setup(opts) -- pass the same opts you use in your real spec, if any
					-- end

					local Highlight = require("todo-comments.highlight")
					local make_entry = require("telescope.make_entry")
					local pickers = require("telescope.builtin")
					local entry_display = require("telescope.pickers.entry_display")

					opts = picker_opts or {}
					opts.vimgrep_arguments = { Config.options.search.command }
					vim.list_extend(opts.vimgrep_arguments, Config.options.search.args)
					opts.search = Config.search_regex(vim.tbl_keys(Config.keywords))
					opts.prompt_title = "To-Do List"
					opts.use_regex = true

					local entry_maker = make_entry.gen_from_vimgrep(opts)

					-- columns: icon | todo text (flexible) | file:line (fixed width)
					local ICON_WIDTH = 2
					local LOC_WIDTH = 15
					local SEP_COUNT = 2 -- two separators between your 3 columns

					local displayer = entry_display.create({
						separator = " ",
						items = {
							{ width = ICON_WIDTH },
							{ width = function(_, max_columns, _)
								return max_columns - ICON_WIDTH - LOC_WIDTH - SEP_COUNT
							end },
							{ width = LOC_WIDTH, right_justify = true },
						},
					})

					opts.entry_maker = function(line)
						local ret = entry_maker(line)
						ret.display = function(entry)
							local text = entry.text
							local icon, hl_group = " ", nil

							local start, _, kw = Highlight.match(text)
							if start then
								kw = Config.keywords[kw] or kw
								icon = Config.options.keywords[kw].icon or " "
								hl_group = "TodoFg" .. kw
								text = vim.trim(text:sub(start))
							end
							local filename = vim.fs.basename(entry.filename)
							return displayer({
								{ icon, hl_group },
								{ text, hl_group },
								{ filename, "Comment" },
							})
						end
						return ret
					end

					pickers.grep_string(opts)
				end

				vim.api.nvim_create_user_command("TodoTelescopeCustom", function()
					todo_custom({})
				end, {})
				require("telescope").load_extension("todo-comments") -- forces it to load & cache

				local ext = require("telescope").extensions["todo-comments"]
				ext["todo"] = todo_custom
				ext["todo-comments"] = todo_custom 
			end
		},
	}
