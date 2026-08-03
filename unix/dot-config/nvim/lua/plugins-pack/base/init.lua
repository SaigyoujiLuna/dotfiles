local M = {}
M.packages = {
  "https://github.com/folke/lazydev.nvim",
}
M.config = function()
  require("plugins-pack.base.lazydev")
end
return M
