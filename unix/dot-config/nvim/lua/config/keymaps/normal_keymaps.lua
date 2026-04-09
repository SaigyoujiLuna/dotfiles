-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Normal mode", noremap = true })

-- better up/down
keymap.set(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true, noremap = true }
)
keymap.set(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true, noremap = true }
)
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true, noremap = true })
keymap.set(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'k'",
  { desc = "Up", expr = true, silent = true, noremap = true }
)

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", noremap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", noremap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", noremap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", noremap = true })

-- clipboard support
keymap.set("n", "<D-s>", ":w<CR>") -- Save
keymap.set("v", "<D-c>", '"+y') -- Copy
keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
--ui toggle
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw", { noremap = true })
Snacks.toggle.zen():map("<leader>uz", { noremap = true })
Snacks.toggle.dim():map("<leader>ud", { noremap = true })
