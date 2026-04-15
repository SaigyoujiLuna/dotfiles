return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cond = not vim.g.vscode,
  config = function()
    require("hardtime").setup({
      disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
    })
  end,
}
