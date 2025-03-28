return {
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "j-hui/fidget.nvim",    opts = {} },
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"goimports",
					"gofumpt",
					"gomodifytags",
					"impl",
					"delve",
					"lua_ls",
					"tsserver",
					"gopls",
					"html",
					"cssls",
					"tailwindcss",
					"htmx-lsp",
					"templ",
					"prettier",
					"golangci-lint",
					"stylua",
				},
			})
			require("mason").install_all()
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"rust",
					"typescript",
					"tsx",
					"json",
					"yaml",
					"toml",
					"html",
					"css",
					"java",
					"go",
					"gomod",
					"gowork",
					"gosum",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
