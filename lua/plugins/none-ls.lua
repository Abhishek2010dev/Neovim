return {
  -- Ensure plenary.nvim is loaded first
  {
    "nvim-lua/plenary.nvim",
    priority = 1000, -- Adjust priority as needed to load before other plugins
  },
  { "nvimtools/none-ls-extras.nvim" },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local nls = require("null-ls")
      nls.setup({
        sources = {
          nls.builtins.diagnostics.sqlfluff,
          require("none-ls.code_actions.eslint"),
          nls.builtins.formatting.sqlfluff,
          nls.builtins.formatting.prettier,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
