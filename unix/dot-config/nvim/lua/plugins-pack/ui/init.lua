local group = YukiVim.augroup("plugins-pack-ui")
vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-lualine/lualine.nvim",
  -- noice required
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/folke/which-key.nvim",
})
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  once = true,
  callback = function()
    vim.schedule(function()
      require("plugins-pack.ui.lualine")
      require("plugins-pack.ui.whichkey")
      require("plugins-pack.ui.noice")
    end)
  end,
})

require("plugins-pack.ui.catppuccin")
require("plugins-pack.ui.tree")
