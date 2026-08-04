if vim.g.vscode then
  return
end

local wk = require("which-key")
wk.setup({})
wk.add({
  { "<leader>f", group = "file" },
  { "<leader>c", group = "code" },
  { "<leader>d", group = "debug" },
  { "<leader>g", group = "git" },
  { "<leader>b", group = "buffer" },
  { "<leader>u", group = "ui" },
  { "<leader>x", group = "diagnostic" },
  { "<leader>d", group = "debug" },
  { "[", group = "prev" },
  { "]", group = "next" },
  { "g", group = "goto" },
})

vim.keymap.set({ "n" }, "<leader>?", wk.show, { desc = "Buffer Keymaps (which-key)" })
