return {
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "j-hui/fidget.nvim",    opts = {} },
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"lua_ls",
					"tsserver",
					"gopls",
					"html",
					"cssls",
					"tailwindcss",
					"htmx-lsp",
					"templ",
					"prettier",
					"stylua",
					"goimports",
					"gofumpt",
					"gomodifytags",
					"impl",
					"delve"
				},
			})
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
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"hrsh7th/cmp-nvim-lsp",
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require('nvim-ts-autotag').setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["html"] = {
						enable_close = false
					}
				}
			})
		end
	}
}
