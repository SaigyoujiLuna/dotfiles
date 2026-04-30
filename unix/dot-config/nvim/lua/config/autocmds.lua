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

local function set_normal_float_highlight()
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_normal_float_highlight,
})
