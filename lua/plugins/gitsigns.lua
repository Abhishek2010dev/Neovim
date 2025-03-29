return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true, -- Enable inline blame by default
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]c", function() gs.nav_hunk("next") end, "Next hunk")
				map("n", "[c", function() gs.nav_hunk("prev") end, "Previous hunk")

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
				map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
				map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>hb", gs.blame_line, "Blame line")
				map("n", "<leader>hd", gs.diffthis, "Diff against index")
				map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff against last commit")

				-- Toggles
				map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle blame line")
				map("n", "<leader>tD", gs.preview_hunk_inline, "Toggle deleted lines preview")
			end,
		},
	},
}
