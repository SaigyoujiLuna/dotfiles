require("plugins-pack.editor.telescope")
vim.pack.add({
  { src = "https://github.com/olimorris/codecompanion.nvim", version = vim.version.range("^19.0.0") },
  "https://github.com/supermaven-inc/supermaven-nvim",
  { src = "https://github.com/echasnovski/mini.pairs" },
  "https://github.com/stevearc/conform.nvim",
  {src = "https://github.com/echasnovski/mini.indentscope", version = "stable"},
  "https://codeberg.org/andyg/leap.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/echasnovski/mini.surround",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/folke/trouble.nvim",
  { src = "https://github.com/akinsho/bufferline.nvim", version = vim.version.range("*") },
  "https://github.com/HiPhish/rainbow-delimiters.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
})
local group = YukiVim.augroup("plugins-pack-editor")
vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  group = group,
  callback = function()
    require("plugins-pack.editor.indent_line")
    require("plugins-pack.editor.todo")
    require("plugins-pack.editor.formatter")
    require("plugins-pack.editor.trouble")
    require("plugins-pack.editor.lint")
    require("plugins-pack.editor.bufferline")
    require("plugins-pack.editor.rainbow")
    require("plugins-pack.editor.git")
  end,
})
