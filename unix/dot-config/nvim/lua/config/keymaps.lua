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

-- Lspsaga config
keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto definition" })
keymap.set("n", "gD", "<cmd>Lspsaga goto_type_definition<CR>", { desc = "Goto type definition" })
keymap.set("n", "gr", "<cmd>Lspsaga finder ref<CR>", { desc = "Goto reference" })
keymap.set("n", "gI", "<cmd>Lspsaga finder imp<CR>", { desc = "Goto implementation" })
keymap.set("n", "<leader>cd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto definition" })
keymap.set("n", "<leader>cD", "<cmd>Lspsaga goto_type_definition<CR>", { desc = "Goto type definition" })
keymap.set("n", "<leader>cr", "<cmd>Lspsaga finder ref<CR>", { desc = "Goto reference" })
keymap.set({ "n" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code action" })
keymap.set({ "n" }, "<leader>cn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
keymap.set({ "n" }, "<leader>ci", "<cmd>Lspsaga finder imp<CR>", { desc = "Goto implementation" })

keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show document" })
keymap.set({ "n", "i", "t" }, "<C-/>", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle terminal" })
keymap.set({ "n", "i", "t" }, "<C-_>", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle terminal" })
