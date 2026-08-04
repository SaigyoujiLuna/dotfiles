return {
  packages = {
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/folke/which-key.nvim",
    { src = "https://github.com/nvim-mini/mini.notify", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.pairs", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.surround", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.icons", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.diff", version = "stable" },

  },
  config = function()
    local group = YukiVim.augroup("plugins-pack-ui")
    vim.api.nvim_create_autocmd("VimEnter", {
      group = group,
      once = true,
      callback = function()
        vim.schedule(function()
          require("plugins.ui.lualine")
          require("plugins.ui.whichkey")
        end)
      end,
    })
    require("plugins.ui.catppuccin")
    require("plugins.ui.mini")
    require("plugins.ui.tree")
  end,
}
