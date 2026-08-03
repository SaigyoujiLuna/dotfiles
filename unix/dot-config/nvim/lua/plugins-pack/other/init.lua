local M = {}
M.packages = {
  "https://github.com/fei6409/log-highlight.nvim",
}
M.config = function()
  local group = YukiVim.augroup("plugins-pack-other")
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    once = true,
    callback = function()
      require("plugins-pack.other.loghighlight")
    end,
  })
end

return M
