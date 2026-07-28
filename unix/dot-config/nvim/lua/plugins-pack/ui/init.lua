vim.pack.add({
  {src = "https://github.com/catppuccin/nvim", name = "catppuccin"},
  { src = "https://github.com/akinsho/bufferline.nvim", version = vim.version.range("*") },
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/j-hui/fidget.nvim",
  -- noice required
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/folke/which-key.nvim",
})
require("plugins-pack.ui.catppuccin")
require("plugins-pack.ui.bufferline")
require("plugins-pack.ui.tree")
require("plugins-pack.ui.lualine")
require("plugins-pack.ui.fidget")
require("plugins-pack.ui.noice")
require("plugins-pack.ui.whichkey")
