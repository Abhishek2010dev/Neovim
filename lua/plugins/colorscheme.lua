return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local transparent = true

    require("tokyonight").setup({
      transparent = transparent,
      theme = "night",
      styles = {
        sidebars = transparent and "transparent" or "dark",
        floats = transparent and "transparent" or "dark",
      },
    })

    vim.cmd("colorscheme tokyonight")
  end,
}
