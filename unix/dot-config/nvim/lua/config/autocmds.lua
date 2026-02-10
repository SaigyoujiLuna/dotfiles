vim.api.nvim_create_autocmd("TextYankPost", {
  group = YukiVim.augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd("LazyDone", {
--     callback = function()
--         require("config.keymaps")
--     end
-- })
