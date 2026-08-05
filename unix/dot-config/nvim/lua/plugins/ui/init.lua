return {
  packages = {
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua", version = vim.version.range("*") },
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/folke/which-key.nvim",
    { src = "https://github.com/nvim-mini/mini.notify", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.pairs", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.surround", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.icons", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.diff", version = "stable" },
    { src = "https://github.com/akinsho/bufferline.nvim", version = vim.version.range("*") },
  },
  config = function()
    require("plugins.ui.mini")
    require("plugins.ui.catppuccin")
    require("plugins.ui.tree")
    require("plugins.ui.lualine")
    require("plugins.ui.bufferline")
    require("plugins.ui.whichkey")
  end,
}
