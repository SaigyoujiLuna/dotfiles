local group = YukiVim.augroup("plugins-pack-other")
vim.pack.add({
  "https://github.com/m4xshen/hardtime.nvim",
  "https://github.com/fei6409/log-highlight.nvim",
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  once = true,
  callback = function()
    require("plugins-pack.other.loghighlight")
    require("plugins-pack.other.hardtime")
  end,
})
