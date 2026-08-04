local M = {}

local group = YukiVim.augroup("plugins-pack-ui")
M.packages = {
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/which-key.nvim",
  { src = "https://github.com/nvim-mini/mini.notify", version = "stable" },
}
M.config = function()
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
  require("plugins.ui.tree")
  require("plugins.ui.mini")
end
return M
