require("trouble").setup({
  auto_preview = false,
  auto_close = true,
  auto_fold = false,
  fold_open = "",
})
local keymap = vim.keymap.set
keymap({ "n" }, "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
keymap({ "n" }, "<leader>xX", "<cmd>Trouble diagnostics tpgg;e filter.buf=0<CR>", { desc = "Buffer Diagnostics" })
keymap({ "n" }, "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap({ "n" }, "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
