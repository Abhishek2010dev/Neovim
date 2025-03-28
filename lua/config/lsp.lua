-- Enable signcolumn for diagnostic signs
vim.opt.signcolumn = "yes"

-- Setup default LSP capabilities
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
    vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Configure diagnostics to show inline errors
vim.diagnostic.config({
	virtual_text = { spacing = 2, prefix = "●" }, -- Enable inline errors
	signs = true, -- Show signs in signcolumn
	underline = true, -- Underline errors
	update_in_insert = false, -- Don't update while typing
	severity_sort = true, -- Sort by severity
})

-- LSP keybindings
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
		vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "gc", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

		-- Diagnostic navigation
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
		vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
	end,
})

-- Setup Mason and Mason-LSPConfig
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "rust_analyzer" },
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})

-- Configure cmp (completion)
local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
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
