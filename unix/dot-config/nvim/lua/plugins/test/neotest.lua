return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "mrcjkb/rustaceanvim",
    },
    cond = not vim.g.vscode,
    ft = { "rust" },
    opts = function()
      return {
        adapters = {
          require("rustaceanvim.neotest"),
        },
        status = { virtual_text = true },
      }
    end,
    keys = {
      { "<leader>t", "", desc = "+test" },
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach to Test",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest (Neotest)",
      },
      {
        "<leader>tu",
        function()
          require("neotest").output()
        end,
        desc = "Test Output (Neotest)",
      },
    },
  },
}
