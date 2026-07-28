if vim.g.vscode then
  return
end
local group = YukiVim.augroup("plugins-pack-lang")
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = group,
  once = true,
  callback = function()
    require("plugins-pack.lang.lsp")
    require("plugins-pack.lang.clangd")
    require("plugins-pack.lang.d2")
    require("plugins-pack.lang.java")
    require("plugins-pack.lang.markdown")
    require("plugins-pack.lang.python")
    require("plugins-pack.lang.rust")
    require("plugins-pack.lang.typescript")
  end,
})
