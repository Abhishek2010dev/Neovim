return {
  {
    "nvim-java/nvim-java",
    dependencies = {
      "mfussenegger/nvim-jdtls",    -- Java LSP support
      "JavaHello/spring-boot.nvim", -- Spring Boot enhancements
      "ibhagwan/fzf-lua",           -- Optional: fuzzy finder for navigation
    },
    config = function()
      require("java").setup()
      require("spring_boot").setup({})
    end,
  },
}
