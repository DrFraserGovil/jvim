return {
	{
		-- sessions per project folder: saved on exit, restored when nvim starts with no file arguments
		"rmagatti/auto-session",
		lazy = false,
		init = function()
			-- what a session keeps; no terminal buffers (they come back dead)
			vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"
		end,
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			-- never save a session for these folders themselves (their subfolders are fine)
			suppressed_dirs = { "~/", "/", "/tmp", "~/Downloads", "~/Documents", "~/docs", "~/.config/nvim" },
			-- ~/docs and ~/Documents are the same folder: one session per project, whichever path it was opened by
			resolve_symlinks = true,
			-- panels which don't restore well are closed before saving
			close_filetypes_on_save = { "checkhealth", "trouble" },
			-- :AutoSession search opens in Telescope's normal mode, for moving about with j/k rather than typing
			session_lens = {
				picker = "telescope",
				picker_opts = { initial_mode = "normal" },
			},
		},
	},
}
