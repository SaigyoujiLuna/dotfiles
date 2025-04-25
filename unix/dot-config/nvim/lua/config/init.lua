_G.YukiVim = require("utils")
---@class YukiVimConfig
local M = {}
---@param name "autocmds" | "keymaps" | "options" | "lazy"
function M.load(name)
  require("config." .. name)
end
M.did_init = false
function M.init()
  if M.did_init then
    return
  end

  M.did_init = true
  M.load("options")
  M.load("lazy")
end
function M.setup()
  local group = vim.api.nvim_create_augroup("YukiVim", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    callback = function()
      M.load("autocmds")
      M.load("keymaps")
    end,
  })
end
return M
