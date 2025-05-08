-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Normal mode" })

-- better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- lsp config
keymap.set("n", "gd", function()
  return vim.lsp.buf.definition()
end, { desc = "Goto definition" })

keymap.set("n", "gD", function()
  return vim.lsp.buf.type_definition()
end, { desc = "Goto type definition" })
keymap.set("n", "gr", function()
  return vim.lsp.buf.references()
end, { desc = "Goto reference" })
keymap.set("n", "gI", function()
  return vim.lsp.buf.implementation()
end, { desc = "Goto implementation" })
keymap.set("n", "<leader>cd", function()
  return vim.lsp.buf.definition()
end, { desc = "Goto definition" })
keymap.set("n", "<leader>cD", function()
  return vim.lsp.buf.type_definition()
end, { desc = "Goto type definition" })

keymap.set("n", "<leader>cr", function()
  return vim.lsp.buf.references()
end, { desc = "Goto reference" })
keymap.set({ "n" }, "<leader>ca", function()
  return vim.lsp.buf.code_action()
end, { desc = "Code action" })

keymap.set({ "n" }, "<leader>cn", function()
  return vim.lsp.buf.rename()
end, { desc = "Rename" })
keymap.set({ "n" }, "<leader>ci", function()
  return vim.lsp.buf.implementation()
end, { desc = "Goto implementation" })

keymap.set("n", "K", function()
  return vim.lsp.buf.hover()
end, { desc = "Show document" })

--ui toggle
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.zen():map("<leader>uz")
