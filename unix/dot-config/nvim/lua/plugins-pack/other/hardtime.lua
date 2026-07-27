if vim.g.vscode then
  return
end

require("hardtime").setup({
  disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
})
