return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	config = function()
		require("lsp_signature").setup({
			bind = true,
			hint_enable = false, -- disable virtual text hints
			floating_window = true,
			handler_opts = { border = "rounded" },
		})
	end
}
