local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Normal mode", noremap = true })

-- better up/down
-- stylua: ignore
keymap.set( { "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true, noremap = true })
-- stylua: ignore
keymap.set( { "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true, noremap = true })
-- stylua: ignore
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true, noremap = true })
-- stylua: ignore
keymap.set( { "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true, noremap = true })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", noremap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", noremap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", noremap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", noremap = true })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- clipboard support
keymap.set("n", "<D-s>", ":w<CR>") -- Save
keymap.set("v", "<D-c>", '"+y') -- Copy
keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

--ui toggle
keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("Wrap " .. (vim.wo.wrap and "Enabled" or "Disabled"))
end, { desc = "Toggle Wrap", noremap = true })

--lsp
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
keymap.set("n", "gh", vim.diagnostic.show, { desc = "Line Diagnostics" })
keymap.set("n", "g[", diagnostic_goto(false), { desc = "Prev Diagnostic" })
keymap.set("n", "g]", diagnostic_goto(true), { desc = "Next Diagnostic" })

keymap.set("n", "<C-/>", function()
  YukiVim.terminal.toggle()
end)
keymap.set("n", "<C-t>", function()
  YukiVim.terminal.toggle()
end)
