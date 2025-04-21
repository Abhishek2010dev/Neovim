-- Enable signcolumn for diagnostic signs
vim.opt.signcolumn = "yes"

-- Setup default LSP capabilities
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
    vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

function hello(name)

end

-- Configure diagnostics to show inline errors
vim.diagnostic.config {
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = '󰅚 ',
			[vim.diagnostic.severity.WARN] = '󰀪 ',
			[vim.diagnostic.severity.INFO] = '󰋽 ',
			[vim.diagnostic.severity.HINT] = '󰌶 ',
		},
	} or {},
	virtual_text = {
		source = 'if_many',
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
} -- LSP keybindings

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "gc", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

		-- Diagnostic navigation
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
		vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
	end,
})

-- Setup Mason and Mason-LSPConfig
local noop = function() end

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"rust_analyzer",
	"lua_ls",
	"gopls",
	"html",
	"cssls",
	"htmx-lsp",
	"templ",
	"typescript-language-server",
	"tailwindcss-language-server",
	"goimports",
	"eslint-lsp",
	"gofumpt",
	"gomodifytags",
	"impl",
	"codelldb",
	"clangd",
	"cpplint",
	"prettier",
	"sqlfluff",
	"pyright",
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
	automatic_installation = false,
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
		rust_analyzer = noop,
	},
})

require('spring_boot').init_lsp_commands()
require("lspconfig").jdtls.setup {
	init_options = {
		bundles = require("spring_boot").java_extensions(),
	},
}

-- Configure cmp (completion)

local cmp = require("cmp")
local lspkind = require('lspkind')

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" }
	},
})

cmp.setup({
	experimental = {
		ghost_text = true,
	},
	sources = {
		{
			name = 'lazydev',
			group_index = 0,
		},
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'nvim_lsp_signature_help' },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text', -- Show both symbol and text
			maxwidth = 50,
			ellipsis_char = '...', -- Use ellipsis for truncation
			show_labelDetails = true,
			before = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					luasnip = "[Snip]",
					path = "[Path]",
					nvim_lsp_signature_help = "[Sig]",
					buffer = "[Buf]"
				})[entry.source.name] or "[Other]"
				return vim_item
			end
		})
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	completion = { completeopt = 'menu,menuone,noinsert' },
	mapping = cmp.mapping.preset.insert({}),
})
-- Autoformat before saving
local buffer_autoformat = function(bufnr)
	local group = "lsp_autoformat"
	vim.api.nvim_create_augroup(group, { clear = false })
	vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		group = group,
		callback = function()
			vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
		end,
	})
end

-- Attach autoformat on LSP attachment
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local id = vim.tbl_get(event, "data", "client_id")
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then
			return
		end
		if client.supports_method("textDocument/formatting") then
			buffer_autoformat(event.buf)
		end
	end,
})
