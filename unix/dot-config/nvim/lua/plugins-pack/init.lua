local group = YukiVim.augroup("plugins-pack")
local pack_list = {
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",
}
local config_list = {}
local resolve = function(name)
  local item = require(name)
  if item.packages then
    vim.list_extend(pack_list, item.packages)
  end
  if item.config then
    config_list[#config_list + 1] = item.config
  end
end

resolve("plugins-pack.base")
-- treesitter 不支持延迟加载
resolve("plugins-pack.treesitter")
resolve("plugins-pack.ui")
resolve("plugins-pack.dap")
resolve("plugins-pack.lang")

vim.pack.add(pack_list)
for _, config in ipairs(config_list) do
  config()
end

require("plugins-pack.editor")
require("plugins-pack.test")
require("plugins-pack.other")
require("plugins-pack.input")
vim.cmd.colorscheme("catppuccin-nvim")
