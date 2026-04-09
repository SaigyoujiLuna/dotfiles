return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
      status = { virtual_text = true },
    },
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
