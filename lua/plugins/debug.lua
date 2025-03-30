return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      -- Open DAP UI when debugging starts
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Keybindings for DAP
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map("n", "<Leader>dc", dap.continue, vim.tbl_extend("force", opts, { desc = "Start/Continue Debugging" }))
      map("n", "<Leader>do", dap.step_over, vim.tbl_extend("force", opts, { desc = "Step Over" }))
      map("n", "<Leader>di", dap.step_into, vim.tbl_extend("force", opts, { desc = "Step Into" }))
      map("n", "<Leader>dO", dap.step_out, vim.tbl_extend("force", opts, { desc = "Step Out" }))
      map("n", "<Leader>db", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "Toggle Breakpoint" }))
      map("n", "<Leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        vim.tbl_extend("force", opts, { desc = "Set Conditional Breakpoint" }))
      map("n", "<Leader>dr", dap.repl.open, vim.tbl_extend("force", opts, { desc = "Open DAP REPL" }))
      map("n", "<Leader>du", dapui.toggle, vim.tbl_extend("force", opts, { desc = "Toggle DAP UI" }))
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
}
