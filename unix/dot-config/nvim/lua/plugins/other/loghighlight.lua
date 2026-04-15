return {
  {
    "fei6409/log-highlight.nvim",
    cond = not vim.g.vscode,
    config = function()
      require("log-highlight").setup({})
    end,
  },
}
