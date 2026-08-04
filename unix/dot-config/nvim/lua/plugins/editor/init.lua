---@type yukivim.utils.pack.Spec
return {
  packages = {
    { src = "https://github.com/olimorris/codecompanion.nvim", version = vim.version.range("^19.0.0") },
    "https://github.com/supermaven-inc/supermaven-nvim",
    { src = "https://github.com/echasnovski/mini.pairs" },
    "https://github.com/stevearc/conform.nvim",
    { src = "https://github.com/echasnovski/mini.indentscope", version = "stable" },
    "https://codeberg.org/andyg/leap.nvim",
    "https://github.com/mfussenegger/nvim-lint",
    "https://github.com/echasnovski/mini.surround",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/folke/trouble.nvim",
    { src = "https://github.com/akinsho/bufferline.nvim", version = vim.version.range("*") },
    "https://github.com/HiPhish/rainbow-delimiters.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range("*") },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    "https://github.com/fei6409/log-highlight.nvim",
  },
  config = function()
    require("plugins.editor.telescope")
    local group = YukiVim.augroup("plugins-editor")
    vim.api.nvim_create_autocmd("BufEnter", {
      once = true,
      group = group,
      callback = function()
        require("plugins.editor.indent_line")
        require("plugins.editor.todo")
        require("plugins.editor.formatter")
        require("plugins.editor.trouble")
        require("plugins.editor.lint")
        require("plugins.editor.bufferline")
        require("plugins.editor.rainbow")
        require("plugins.editor.git")
        require("plugins.editor.loghighlight")
      end,
    })
  end,
}
