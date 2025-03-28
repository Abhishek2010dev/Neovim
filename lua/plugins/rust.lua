return {
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				crates = {
					enabled = true,
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				},
			}
		end,
	},
}
