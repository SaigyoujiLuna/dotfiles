return {
  {
    "olimorris/codecompanion.nvim",
    version = vim.version.range("^19.0.0"),
    config = function()
      require("codecompanion").setup({
        interactions = {
          chat = {
            adapter = "opencode",
          },
        },
      })
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        disable_inline_suggestion = false,
        ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
      })
    end,
  },
}
