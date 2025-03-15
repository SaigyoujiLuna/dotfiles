return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  {
    "folke/lazydev.nvim",
    optional = true,
    opts = function(_, opts)
      opts.library = opts.library or {};
      opts.library = vim.tbl_deep_extend("force", {}, opts.library, { "nvim-dap-ui" })
    end,
  },
}
