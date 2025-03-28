return {
	{ "fatih/vim-go" },
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup {
				-- log level, you might consider using DEBUG or TRACE for debugging the plugin
				log_level = vim.log.levels.INFO,

				-- timeout for running internal commands
				timeout = 2000,

				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "gotests",
					impl = "impl",
					iferr = "iferr",
				},
				gotests = {
					-- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
					template = "default",
					-- path to a directory containing custom test code templates
					template_dir = nil,
					-- switch table tests from using slice to map (with test name for the key)
					named = false,
				},
				gotag = {
					transform = "snakecase",
					-- default tags to add to struct fields
					default_tag = "json",
				},
				iferr = {
					-- choose a custom error message
					message = nil,
				},
			}

			vim.api.nvim_set_keymap('n', '<leader>at', ':GoTagAdd<CR>', { noremap = true, silent = true })

			vim.api.nvim_set_keymap('n', '<leader>rt', ':GoTagRm<CR>', { noremap = true, silent = true })

			vim.api.nvim_set_keymap('n', '<leader>gt', ':GoTestAdd<CR>', { noremap = true, silent = true })

			vim.api.nvim_set_keymap('n', '<leader>ga', ':GoTestsAll<CR>', { noremap = true, silent = true })

			vim.api.nvim_set_keymap('n', '<leader>ge', ':GoTestsExp<CR>', { noremap = true, silent = true })

			vim.api.nvim_set_keymap('n', '<leader>im', ':GoImpl ', { noremap = true, silent = false })

			vim.api.nvim_set_keymap('n', '<leader>ie', ':GoIfErr<CR>', { noremap = true, silent = true })
		end,
		build = function()
			vim.cmd [[silent! GoInstallDeps]]
		end,
	},
}
