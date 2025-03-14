return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function (_, opts)
      require("which-key").setup(opts)
      require("which-key").add({
        {"<leader>f", group = "file"},
        {"<leader>c", group = "code"}
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show()
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
