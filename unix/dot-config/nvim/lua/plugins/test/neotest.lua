vim.pack.add({
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/antoinemadec/fixcursorhold.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/mrcjkb/rustaceanvim",
})
if vim.g.vscode then
  return
end

local keymap = vim.keymap.set

require("neotest").setup({
  adapters = {
    require("rustaceanvim.neotest"),
  },
  status = { virtual_text = true, enabled = true },
})
keymap({ "n" }, "<leader>t", "", { desc = "+test" })
--stylua: ignore
keymap({ "n" }, "<leader>ta", function() require("neotest").run.attach() end, { desc = "Attach to Test" })
--stylua: ignore
keymap( { "n", }, "<leader>tr", function() require("neotest").run.run() end, { desc = "Run Nearest (Neotest)" })
--stylua: ignore
keymap({ "n" }, "<leader>tu", function() require("neotest").output() end, { desc = "Test Output (Neotest)" })
