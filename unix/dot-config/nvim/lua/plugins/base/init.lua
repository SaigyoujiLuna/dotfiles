local M = {}
M.packages = {
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",
}
M.config = function()
  require("plugins.base.lazydev")
end
return M
