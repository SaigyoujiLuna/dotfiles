return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      require("which-key").add({
        { "<leader>f", group = "file" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "debug"},
        { "<leader>g", group = "git"},
        { "<leader>b", group = "buffer"},
        { "<leader>u", group = "ui"},
        { "[", group = "prev"},
        { "]", group = "next"},
        { "g", group = "goto"},
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show()
        end,
        desc = "Buffer Keymaps (which-key)",
      },
    },
  },
}
